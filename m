Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAEVqo>; Fri, 5 Jan 2001 16:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132109AbRAEVqe>; Fri, 5 Jan 2001 16:46:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24328 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129267AbRAEVq1>; Fri, 5 Jan 2001 16:46:27 -0500
Subject: Re: [PATCH] VESA framebuffer w/ MTRR locks 2.4.0 on init
To: bmayland@leoninedev.com (Bryan Mayland)
Date: Fri, 5 Jan 2001 21:48:05 +0000 (GMT)
Cc: kraxel@bytesex.org (Gerd Knorr), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A563F5A.9B50B2B3@leoninedev.com> from "Bryan Mayland" at Jan 05, 2001 04:40:42 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EeiW-0008VW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     So what do you say.  Can we use my patch to allow the user to override the VESA
> detected memory size... or does anyone else have a better plan?

It seems a passable solution. The mtrr bug is real either way and wants a fix.
If the 2Mb reporting is wrong perhaps they will fix the bios ;)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
