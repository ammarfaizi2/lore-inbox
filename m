Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbTBJQTY>; Mon, 10 Feb 2003 11:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbTBJQTY>; Mon, 10 Feb 2003 11:19:24 -0500
Received: from web20409.mail.yahoo.com ([66.163.169.97]:35432 "HELO
	web20421.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264940AbTBJQTW>; Mon, 10 Feb 2003 11:19:22 -0500
Message-ID: <20030210162852.55402.qmail@web20421.mail.yahoo.com>
Date: Mon, 10 Feb 2003 08:28:52 -0800 (PST)
From: devnetfs <devnetfs@yahoo.com>
Subject: Re: compiling kernel with debug and optimization 
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2721.1044876757@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for you reply Keith :)

The reason I asked this question is -- Distro's like RH (i guess it
holds for others too) DONT distribute kernels compiled with -g and
I was wondering why? 

Agreed about the compile-time+disk overhead, but that's ONE time
affair. Analyzing a system-core-dump of a "-g" built kernel (using
MCL's crash) is much easier and fruitful than otherwise.

so is it (just) the disk-space overhead that keeps distributions 
from NOT compiling with "-g" option?!

Thanks once again,

Regards,
A.



--- Keith Owens <kaos@ocs.com.au> wrote:
> On Mon, 10 Feb 2003 03:11:51 -0800 (PST), 
> devnetfs <devnetfs@yahoo.com> wrote:
> >Does compiling with -g option degrade performance? IMO it should
> NOT.
> 
> Compiling with -g slows down compilation and link, mainly because of
> the extra debugging data that has to be copied around.  -g
> significantly increases disk usage.
> 
> >If that's true, then why dont we compile kernels with both -g and
> -O2
> >always? Also does using -g AND -O2 cause some optimizations to be 
> >missed out?
> 
> With gcc, compiling with -g should have no effect on the kernel.  One
> of my occasional tests is to build vmlinux with and without -g, run
> both through strip -g and compare the results.  They should be
> identical except for the build timestamp.
> 


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
