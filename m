Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262832AbRE0R0m>; Sun, 27 May 2001 13:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262834AbRE0R03>; Sun, 27 May 2001 13:26:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56844 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262832AbRE0R0U>; Sun, 27 May 2001 13:26:20 -0400
Subject: Re: VIA IDE no go with 2.4.5-ac1
To: green@linuxhacker.ru (Oleg Drokin)
Date: Sun, 27 May 2001 18:23:14 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), vojtech@suse.cz,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010527210628.A998@linuxhacker.ru> from "Oleg Drokin" at May 27, 2001 09:06:28 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1544G2-00027w-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It does boot once I build without ACPI. (though vanilla 2.4.5 boots regardless
> of that). It disabled DMA by default for some strange reason, so I get 2.5Mb/sec

I will go and review the ACPI but I believe -ac and Linus acpi match exactly

> BTW, 2.4.5-ac1 fails on unmounting reiserfs for me with this diagnostic:
> journal_begin called without kernel lock held
> kernel BUG at journal.c:423!
> I've seen this was reported for 2.4.5, too.

Al Viro posted a fix for that one

