Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263968AbTCWWpf>; Sun, 23 Mar 2003 17:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263969AbTCWWpf>; Sun, 23 Mar 2003 17:45:35 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:5386 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S263968AbTCWWpe>;
	Sun, 23 Mar 2003 17:45:34 -0500
Date: Sun, 23 Mar 2003 23:56:34 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: LKML <linux-kernel@vger.kernel.org>
Cc: wa1ter@myrealbox.com, andmike@us.ibm.com
Subject: Re: [Bug 492] New: Zip drive parallel-port driver causes segfault in 2.5.x
Message-ID: <20030323225634.GA10164@win.tue.nl>
References: <2070000.1048457694@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2070000.1048457694@[10.10.2.4]>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 02:14:54PM -0800, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=492
> 
>            Summary: Zip drive parallel-port driver causes segfault in 2.5.x
>     Kernel Version: 2.5.x
>             Status: NEW
>           Severity: high
>              Owner: andmike@us.ibm.com
>          Submitter: wa1ter@myrealbox.com
> 
> 
> Problem Description: ppa module doesn't work properly and, if compiled into
> kernel it causes a kernel panic at boot.
> Steps to reproduce:compile ppa.ko as a module and modprobe ppa:
> 
> Error messages include 'scheduling while atomic' and 'oops: 0004 [#2]'
> and 'unable to handle kernel paging request' and 'modprobe exited with
> preempt_count 1'.
> 
> This same problem has existed at least since kernel 2.5.49 when I
> started trying the 2.5 series, and I suspect that ppa has never
> worked with 2.5 kernels, but I don't know for sure.  The driver
> works fine with 2.4 kernels.
> 
> Note:  it is NOT necessary to have a parallel Zip drive to test this
> kernel module.  The ppa module should load without error even with no
> Zip drive connected!

Just compiled ppa and insmod'ed. No problems. [2.5.65, no such Zip drive]

