Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268966AbTGUAEd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 20:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269010AbTGUAEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 20:04:33 -0400
Received: from [200.104.148.52] ([200.104.148.52]:7040 "EHLO
	sleipnir.valparaiso.cl") by vger.kernel.org with ESMTP
	id S268966AbTGUAEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 20:04:32 -0400
Message-Id: <200307210019.h6L0J2J02034@sleipnir.valparaiso.cl>
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Separate ACPI_SLEEP and SOFTWARE_SUSPEND options 
In-reply-to: Your message of "Sun, 20 Jul 2003 20:40:23 +0200."
             <20030720184023.GC269@elf.ucw.cz> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sun, 20 Jul 2003 20:19:02 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> said:

[...]

> > What happens on a machine which is sharing swap space between two
> > operating systems?  Do we have a way to mark a swap partition which is
> > used for suspend data as unusable?  Maybe we could change the
> > partition type from 82 to something else.
> 
> swsusp changes swap's signature, so swapon will fail.

Yes, but AFAIU the way to use it with "other" OSes is to generate the swap
space on boot, so this is irrelevant.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
