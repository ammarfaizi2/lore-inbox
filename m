Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265661AbTAJSZT>; Fri, 10 Jan 2003 13:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265628AbTAJSYe>; Fri, 10 Jan 2003 13:24:34 -0500
Received: from [193.158.237.250] ([193.158.237.250]:44679 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265636AbTAJSYa>; Fri, 10 Jan 2003 13:24:30 -0500
Date: Fri, 10 Jan 2003 19:33:05 +0100
Message-Id: <200301101833.h0AIX4i02881@mail.intergenia.de>
To: Andrew Morton <akpm@digeo.com>
From: rct@gherkin.frus.com (Bob_Tracy(0000))
Subject: Re: XFree86 vs. 2.5.54 - reboot [rescued]
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > "Bob_Tracy(0000)" wrote:
> > > > AMD K6-III 450 running a 2.4.19 kernel with vesafb, XFree86 4.1.0, and
> > > > a USB mouse works fine.  Same setup with a 2.5.54 kernel does a cold
> > > > reboot when I type "startx".
> 
> Yup.  It must be something else then.  Perhaps you should try disabling
> various DRM/AGP type things in config, see if that helps.

I wrote:
> 2.5.55 appears to work fine with CONFIG_AGP and CONFIG_DRM undefined.
> I'll retry with CONFIG_AGP_MODULE next...

CONFIG_AGP_MODULE enabled works fine with CONFIG_AGP_VIA_MODULE.  I'll try
turning everything back on (AGP 3.0 compliance, DRM) and see what happens.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

