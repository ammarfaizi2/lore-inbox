Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAEWBg>; Fri, 5 Jan 2001 17:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEWB0>; Fri, 5 Jan 2001 17:01:26 -0500
Received: from tamqfl1-ar1-128-154.dsl.gtei.net ([4.33.128.154]:33530 "EHLO
	linus.southpark") by vger.kernel.org with ESMTP id <S129183AbRAEWBX>;
	Fri, 5 Jan 2001 17:01:23 -0500
Message-ID: <3A564430.897167F3@leoninedev.com>
Date: Fri, 05 Jan 2001 17:01:21 -0500
From: Bryan Mayland <bmayland@leoninedev.com>
Organization: Leonine Development, Inc.
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VESA framebuffer w/ MTRR locks 2.4.0 on init
In-Reply-To: <E14EeiW-0008VW-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> >     So what do you say.  Can we use my patch to allow the user to override the VESA
> > detected memory size... or does anyone else have a better plan?
>
> It seems a passable solution. The mtrr bug is real either way and wants a fix.
> If the 2Mb reporting is wrong perhaps they will fix the bios ;)

Hee hee.  When I first saw this happening back in 1999, I tried to talk to Dell first but
after about an hour on the phone with the support guy trying to explain what VESA BIOS
Extensions were, and why running the Dell diagnostics disk would not solve my problem, I
decided I'd just fix it in software.  Can I get an amen for an open source operating
system?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
