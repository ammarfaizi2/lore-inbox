Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130618AbRCLVSy>; Mon, 12 Mar 2001 16:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130644AbRCLVSp>; Mon, 12 Mar 2001 16:18:45 -0500
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:2527 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S130623AbRCLVSc>; Mon, 12 Mar 2001 16:18:32 -0500
Date: Mon, 12 Mar 2001 21:21:37 +0000 (GMT)
From: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: system call for process information?
In-Reply-To: <Pine.GSO.4.21.0103121324280.25792-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0103122111500.31224-100000@erdos.shef.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2001, Alexander Viro wrote:

> On Mon, 12 Mar 2001, Guennadi Liakhovetski wrote:
> 
> > I need to collect some info on processes. One way is to read /proc
> > tree. But isn't there a system call (ioctl) for this? And what are those
> 
> Occam's Razor.  Why invent new syscall when read() works?

CPU utilisation. Each new application has to calculate it (ps, top, qps,
kps, various sysmons, procmons, etc.). Wouldn't it be worth it having a
syscall for that? Wouldn't it be more optimal?

> > task[], task_struct, etc. about?
> 
> What branch? (2.0, 2.2, 2.4?)

Well, what I mean was - don't these structures contain the information I
am looking for? Let's start from the end - 2.4, then what's the difference
with 2.2 and finally 2.0?

Thanks
Guennadi
___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, U.K.
email: G.Liakhovetski@sheffield.ac.uk


