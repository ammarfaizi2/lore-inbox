Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132870AbRDEMKP>; Thu, 5 Apr 2001 08:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132871AbRDEMJz>; Thu, 5 Apr 2001 08:09:55 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:38921 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S132870AbRDEMJq>;
	Thu, 5 Apr 2001 08:09:46 -0400
Date: Thu, 5 Apr 2001 08:08:51 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
To: Ryan Mack <rmack@mackman.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION] 2.4.3: hotplug_path unresolved in usbcore?
In-Reply-To: <Pine.LNX.4.30.0104042333500.2076-100000@mackman.net>
Message-ID: <Pine.LNX.4.30.0104050806010.13357-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2001, Ryan Mack wrote:

> Sorry for such a stupid question, but I'm stumped (it doesn't take much).
> modprobe reports that hotplug_path is unresolved when it processes
> usbcore. CONFIG_HOTPLUG is defined, so it seems that hotplug_path is
> defined and EXPORTed in kernel/kmod.c, so I'm unsure what the problem is.

I have noticed that sometimes when I change my .config doing a make dep,
make bzImage, make modules, is not enough.  So, I back up my .config, run
make mrproper, copy the .config back, and then make dep, etc.  The option
I know causes this is netfilter under 2.4.2.

> Thanks, Ryan

Hope this helps.
Bart.

-- 
	WebSig: http://www.jukie.net/~bart/sig/


