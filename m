Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263302AbSJJHWD>; Thu, 10 Oct 2002 03:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263281AbSJJHVr>; Thu, 10 Oct 2002 03:21:47 -0400
Received: from [195.39.17.254] ([195.39.17.254]:3332 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263289AbSJJHVp>;
	Thu, 10 Oct 2002 03:21:45 -0400
Message-Id: <200210100725.JAA00155@bug.ucw.cz>
From: Pavel Machek <pavel@ucw.cz>
To: <vojtech@suse.cz>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Date: Thu, 10 Oct 2002 09:23:40 +0200
Subject: Re: Input - Make i8042.c less picky about AUX ports [1/3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ChangeSet@1.597.3.1, 2002-10-08 17:36:32+02:00, vojtech@suse.cz
>   Make i8042.c even less picky about detecting an AUX port because of
>   broken chipsets that don't support the LOOP command or report failure
>   on the TEST command. Hopefully this won't screw any old 386/486
>   systems without the AUX port.

would it make sense to at least printk() on such
broken chipsets? 
