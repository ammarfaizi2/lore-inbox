Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbTJRTW7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 15:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbTJRTW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 15:22:59 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:2723 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261777AbTJRTW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 15:22:57 -0400
Message-ID: <006a01c395ab$4d3f34c0$fb457dc0@tgasterix>
Reply-To: "Thomas Giese" <Thomas.Giese@gmx.de>
From: "Thomas Giese" <Thomas.Giese@gmx.de>
To: "Sean Neakums" <sneakums@zork.net>
Cc: <linux-kernel@vger.kernel.org>
References: <003b01c395a8$22dbf270$fb457dc0@tgasterix> <6uy8viz7bs.fsf@zork.zork.net>
Subject: Re: X crashes under linux-2.6.0-test7-mm1
Date: Sat, 18 Oct 2003 21:09:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Seen: false
X-ID: rfJbrQZZZeiM5Rxksiuo1Uhcjkr9DvqCoGs-s-GAQqiYys3SJy3v83@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

both are set to
CONFIG_AGP=m
CONFIG_AGP_INTEL=m

but, i just saw, that i didn't set
# CONFIG_I2C_I810 is not set
# CONFIG_DRM_I810 is not set
# CONFIG_FB_I810 is not set

may be, this is the reason... i'll try it

thanks,

thomas



-----Ursprüngliche Nachricht----- 
Von: "Sean Neakums" <sneakums@zork.net>
An: "Thomas Giese" <Thomas.Giese@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Gesendet: Samstag, 18. Oktober 2003 21:14
Betreff: Re: X crashes under linux-2.6.0-test7-mm1


> "Thomas Giese" <Thomas.Giese@gmx.de> writes:
>
> > changed the kernel from 2.4.4 to 2.6.0-test7-mm1 i got the following
> > messages after starting X11:  http://www.tgsoftware.de/xfree.txt
>
> It looks like you have forgotten to configure agpgart.
>
> You need to set
>
> CONFIG_AGP=y
> CONFIG_AGP_INTEL=y
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

