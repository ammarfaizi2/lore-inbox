Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWAFM06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWAFM06 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 07:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWAFM06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 07:26:58 -0500
Received: from p549F75DA.dip.t-dialin.net ([84.159.117.218]:26131 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP
	id S1751017AbWAFM05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 07:26:57 -0500
Date: Fri, 6 Jan 2006 13:26:50 +0100
From: Ralf Baechle DL5RB <ralf@linux-mips.org>
To: "Mike McCarthy, W1NR" <mike@w1nr.net>
Cc: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 ax25 system lockup with kissattach
Message-ID: <20060106122650.GA30219@linux-mips.org>
References: <008401c6124f$7ceed0e0$3849a8c0@lan.w1nr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008401c6124f$7ceed0e0$3849a8c0@lan.w1nr.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 06:26:43PM -0500, Mike McCarthy, W1NR wrote:

> >worf:~ # modprobe -v mkiss
> >insmod /lib/modules/2.6.15-20060103193109-debug/kernel/lib/crc16.ko
> >insmod /lib/modules/2.6.15-20060103193109-debug/kernel/net/ax25/ax25.ko
> >insmod
> /lib/modules/2.6.15-20060103193109-debug/kernel/drivers/net/hamradio/mkiss.k
> o
> >worf:~ # kissattach /dev/ttyS0 2m 44.56.10.3
> >AX.25 port 2m bound to device ax0
> 
> 
> That's all folks.  System locked up hard.  Caps lock and scroll lock lights
> flashing.  System needs a hard reset.
> 
> 2.6.14-5 appears to be fine.  Tried recompiled tools and libraries as well.
> Others report similar problems on Debian systems with 2.6.15 kernel as well.

Is this a preemptable and/or SMP kernel?

73 de DL5RB op Ralf

--
Loc. JN47BS / CQ 14 / ITU 28 / DOK A21
