Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVAWBpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVAWBpJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 20:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVAWBpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 20:45:09 -0500
Received: from fire.osdl.org ([65.172.181.4]:27782 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261177AbVAWBpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 20:45:03 -0500
Message-ID: <41F2FFBB.7020300@osdl.org>
Date: Sat, 22 Jan 2005 17:36:59 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: can't compile 2.6.11-rc2 on sparc64
References: <200501230238.55584@gj-laptop>
In-Reply-To: <200501230238.55584@gj-laptop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Piotr Jaskiewicz wrote:
> I get this error :
>  
>  CC      arch/sparc64/kernel/ioctl32.o
> include/asm/uaccess.h: In function `siocdevprivate_ioctl':
> fs/compat_ioctl.c:648: warning: ignoring return value of `copy_to_user', 
> declared with attribute warn_unused_result
> fs/compat_ioctl.c: In function `put_dirent32':
> fs/compat_ioctl.c:2346: warning: ignoring return value of `copy_to_user', 
> declared with attribute warn_unused_result
> fs/compat_ioctl.c: In function `serial_struct_ioctl':
> fs/compat_ioctl.c:2489: warning: ignoring return value of `copy_from_user', 
> declared with attribute warn_unused_result
> fs/compat_ioctl.c:2502: warning: ignoring return value of `copy_to_user', 
> declared with attribute warn_unused_result
> make[1]: *** [arch/sparc64/kernel/ioctl32.o] Error 1
> 
> 
> gcc is 3.4, 64bit. That's ultra5.

Please look for another error.  Run 'make' again.
Those are all just warnings and don't cause a build error.

-- 
~Randy
