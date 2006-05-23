Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWEWRgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWEWRgw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 13:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWEWRgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 13:36:52 -0400
Received: from terminus.zytor.com ([192.83.249.54]:39862 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751017AbWEWRgv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 13:36:51 -0400
Message-ID: <4473482A.3050407@zytor.com>
Date: Tue, 23 May 2006 10:36:42 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [-mm] klibc breaks my initscripts
References: <20060523083754.GA1586@elf.ucw.cz>
In-Reply-To: <20060523083754.GA1586@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> To reproduce: boot with init=/bin/bash
> 
> attempt to
> 
> mount / -oremount,rw
> 
> I have this as my command line:
> 
> root=/dev/hda4 resume=/dev/hda1 psmouse.psmouse_proto=imps
> psmouse_proto=imps psmouse.proto=imps vga=1 pci=assign-busses
> rootfstype=ext2
> 
> Kernel
> 
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 17
> EXTRAVERSION =-rc4-mm3
> 

Will look into immediately.

- a. What distro?
- b. What's the error?
- c. Are you using an initrd/initramfs as well?

	-hpa
