Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267090AbTBHUu4>; Sat, 8 Feb 2003 15:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267098AbTBHUu4>; Sat, 8 Feb 2003 15:50:56 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:15489 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267090AbTBHUuz>; Sat, 8 Feb 2003 15:50:55 -0500
Date: Sat, 8 Feb 2003 15:00:43 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 328] New: The computer seems to hang after the kernel has
 uncompressed and starts to boot.
In-Reply-To: <20980000.1044736584@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302081456180.3031-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Feb 2003, Martin J. Bligh wrote:

> 
> http://bugme.osdl.org/show_bug.cgi?id=328
> 
>            Summary: The computer seems to hang after the kernel has
>                     uncompressed and starts to boot.
>     Kernel Version: 2.5.59
>             Status: NEW
>           Severity: normal
>              Owner: bugme-janitors@lists.osdl.org
>          Submitter: di00enad@ing.hj.se
> 
> 
> Distribution: RedHat 8.0
> Hardware Environment: Acer Aspire 1300 laptop
> Software Environment: RedHat 8.0, GCC 3.2, LILO
> Problem Description: When I have compiled the kernel without problems and 
> restart the computer the only two lines that are printed are:
> 
> Booting 2.5.59
> Uncompressing the kernel, Ok booting the kernel
> 
> then there is no more text printed out and the keyboard do not work. But I
> can  see some activity on the harddisk for about 10 seconds. When I reset
> the  computer fsck is run because the disk was not cleanly unmounted. It
> seems like  the system can almost boot but I can't see anything on the
> screen.

I began to see this bug this weekend myself.  I'm not sure of the cause, 
but it can be worked around by configuring the kernel for built-in (not 
modular) support of virtual terminals (CONFIG_VT) and support for console 
on virtual terminals (CONFIG_VT_CONSOLE).  

