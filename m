Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267237AbTBPRA7>; Sun, 16 Feb 2003 12:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267310AbTBPRA7>; Sun, 16 Feb 2003 12:00:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64528 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267237AbTBPRA6>; Sun, 16 Feb 2003 12:00:58 -0500
Date: Sun, 16 Feb 2003 17:10:50 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Rahul Vaidya <rahulv@csa.iisc.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.53 not compiling
Message-ID: <20030216171050.A12489@flint.arm.linux.org.uk>
Mail-Followup-To: Rahul Vaidya <rahulv@csa.iisc.ernet.in>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0302162227200.18137-100000@topaz.csa.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302162227200.18137-100000@topaz.csa.iisc.ernet.in>; from rahulv@csa.iisc.ernet.in on Sun, Feb 16, 2003 at 10:32:16PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 10:32:16PM +0530, Rahul Vaidya wrote:
> When I tried to "make bzImage" the 2.5.53 it gave me the following error
> 
> In file included from include/linux/spinlock.h:13,
>                  from include/linux/mmzone.h:8,
>                  from include/linux/gfp.h:4,
>                  from include/linux/slab.h:14,
>                  from include/linux/proc_fs.h:5,
>                  from init/main.c:15:
> include/linux/kernel.h:10:20: stdarg.h: No such file or directory
> 
> I am using gcc-3.2. And I did make menuconfig with default settings.

What does:

	gcc -v -iwithprefix include -E - < /dev/null

tell you?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

