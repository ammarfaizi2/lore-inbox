Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312401AbSC3HZC>; Sat, 30 Mar 2002 02:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312403AbSC3HYw>; Sat, 30 Mar 2002 02:24:52 -0500
Received: from Ptrillia.EUnet.sk ([193.87.242.40]:1152 "EHLO meduna.org")
	by vger.kernel.org with ESMTP id <S312401AbSC3HYn>;
	Sat, 30 Mar 2002 02:24:43 -0500
From: Stanislav Meduna <stano@meduna.org>
Message-Id: <200203300724.g2U7OTF01814@meduna.org>
Subject: Re: USB printing via ptal broke between 2.4.17 and .18
To: johannes@erdfelt.com (Johannes Erdfelt)
Date: Sat, 30 Mar 2002 08:24:29 +0100 (CET)
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
In-Reply-To: <20020329144234.E23430@sventech.com> from "Johannes Erdfelt" at mar 29, 2002 02:42:34
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Give usb-uhci a shot. I'm curious if it works better.
> 
> Also, can you try the latest 2.4.19 pre patch (-pre4 I believe)?

2.4.18, usb-uhci
  does start to print, but the whole machine freezes a page or two
  later (Alt-SysRq works). This was also the reason I chose uhci
  some versions ago.

2.4.19-pre5, uhci
  does not work. It appeared start to print (sucked the paper in),
  but that was it

2.4.19-pre5, usb-uhci
  the machine does not even come up, the modprobe usb-uhci in the
  boot scripts freezes

Regards
-- 
                                       Stano

