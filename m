Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbTBJVEz>; Mon, 10 Feb 2003 16:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265154AbTBJVEz>; Mon, 10 Feb 2003 16:04:55 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:60552 "EHLO
	humilis.humilis.net") by vger.kernel.org with ESMTP
	id <S265099AbTBJVEy>; Mon, 10 Feb 2003 16:04:54 -0500
Date: Mon, 10 Feb 2003 22:14:38 +0100
From: Ookhoi <ookhoi@humilis.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: ookhoi@humilis.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 Oops with insmod aironet4500_proc
Message-ID: <20030210221438.S19693@humilis>
Reply-To: ookhoi@humilis.net
References: <20030210011418.O19693@humilis> <20030210015137.4C0B82C053@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210015137.4C0B82C053@lists.samba.org>
User-Agent: Mutt/1.3.19i
X-Uptime: 19:47:27 up 13 days,  7:48, 22 users,  load average: 1.03, 0.93, 0.86
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote (ao):
> In message <20030210011418.O19693@humilis> you write:
> > When I try to insmod aironet4500_proc, I get an Oops. The driver 
> > itself is buildin (pci).
> > 
> > Kernel (2.5.59) is build with gcc (GCC) 3.2.2 20030131 (Debian
> > prerelease)
> > 
> > module-init-tools version 0.9.9
> > 
> > Is there more info I should provide?
> 
> Looks like you need the following patch (or moreal equiv).
> 
> Hope this helps!
> Rusty.
> 
> diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h

Hi Rusty,

Sorry for the delay. A pentium 133 compiles as fast as you would expect
it to.

Your patch fixes my oops-on-insmod. Of course you knew this already,
didn't you ;-)

Thank you.
