Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWDWSGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWDWSGA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 14:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWDWSGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 14:06:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7946 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751433AbWDWSF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 14:05:59 -0400
Date: Sun, 23 Apr 2006 19:05:51 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH] Update devices.txt
Message-ID: <20060423180551.GB3270@flint.arm.linux.org.uk>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	torvalds@osdl.org, akpm@osdl.org
References: <Pine.LNX.4.61.0604231622120.5207@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0604231622120.5207@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2006 at 04:25:19PM +0200, Jan Engelhardt wrote:
> @@ -262,13 +261,13 @@
>  		NOTE: These devices permit both read and write access.
>  
>    7 block	Loopback devices
> -		  0 = /dev/loop0	First loopback device
> -		  1 = /dev/loop1	Second loopback device
> +		  0 = /dev/loop0	First loop device
> +		  1 = /dev/loop1	Second loop device
>  		    ...
>  
> -		The loopback devices are used to mount filesystems not
> +		The loop devices are used to mount filesystems not
>  		associated with block devices.	The binding to the
> -		loopback devices is handled by mount(8) or losetup(8).
> +		loop devices is handled by mount(8) or losetup(8).

This seems to rename "loopback" to "loop", but leaves the heading
"Loopback devices" using the "loopback" term.  Maybe it should be
"Loop devices" ?

> @@ -1737,7 +1736,7 @@
>  		  0 = /dev/ubda		First user-mode block device
>  		 16 = /dev/udbb		Second user-mode block device
>  		    ...
> -
> +		

This introduces white space at the end of the line.  Please remove.

>  		Partitions are handled in the same way as for IDE
>  		disks (see major number 3) except that the limit on
>  		partitions is 15.
> @@ -2311,7 +2310,7 @@
>  		  0 = /dev/drbd0	First DRBD device
>  		  1 = /dev/drbd1	Second DRBD device
>  		    ...
> -
> +		

This introduces white space at the end of the line.  Please remove.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
