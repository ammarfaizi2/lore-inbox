Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130553AbQKJTWi>; Fri, 10 Nov 2000 14:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131506AbQKJTWa>; Fri, 10 Nov 2000 14:22:30 -0500
Received: from dweeb.lbl.gov ([128.3.1.28]:8458 "EHLO beeble.lbl.gov")
	by vger.kernel.org with ESMTP id <S130553AbQKJTWO>;
	Fri, 10 Nov 2000 14:22:14 -0500
Message-ID: <3A0C486D.184F31AE@lbl.gov>
Date: Fri, 10 Nov 2000 11:11:41 -0800
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-RAID i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: Constantine Gavrilov <const-g@xpert.com>,
        willy tarreau <wtarreau@yahoo.fr>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre21
In-Reply-To: <20001110092846.29847.qmail@web1102.mail.yahoo.com> <20001110114425.E13151@mea-ext.zmailer.org> <3A0BC699.791064BE@xpert.com> <20001110121402.F13151@mea-ext.zmailer.org> <3A0BCC4C.FCE21320@xpert.com> <20001110125150.G13151@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
>         Beowulf systems have "bonding" in use for parallel Ethernet
>         links in between two machines, however THAT is not EtherChannel
>         compatible thing!
> 

Maybe we should adopt's sun naming then, and call it 'Trunking'.

This is the same driver that Beowulf uses, and it is Etherchannel
compatible.

The only part of Etherchannel we don't support is the XOR channel
selection (yuck!) and the automatic configuration of the links (it's a 
MII thing, that's undocumented.)

Leave it as Ethernet Bonding.

-- 
------------------------+--------------------------------------------------
Thomas Davis		| PDSF Project Leader
tadavis@lbl.gov		| 
(510) 486-4524		| "Only a petabyte of data this year?"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
