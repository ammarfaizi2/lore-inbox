Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275816AbRJUK3H>; Sun, 21 Oct 2001 06:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275818AbRJUK25>; Sun, 21 Oct 2001 06:28:57 -0400
Received: from fw2.aub.dk ([195.24.1.195]:32242 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S275816AbRJUK2u>;
	Sun, 21 Oct 2001 06:28:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
Date: Sun, 21 Oct 2001 12:26:23 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <00d401c159ae$6000c7d0$5cbefea9@moya> <20011021093728.A17786@vega.digitel2002.hu> <a05100314b7f8369cf7cd@[192.168.239.101]>
In-Reply-To: <a05100314b7f8369cf7cd@[192.168.239.101]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15vFoM-0000D7-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 October 2001 10:33, Jonathan Morton wrote:
> Probably because they don't know the difference between kernel and
> user space.  Kinda understandable when you come from a Mac or Windows
> background, where (in the former) there is no distinction or (in the
> latter) it's so blurred as to make little difference.
>
> And if they *do* understand it, from a dispassionate point of view,
> it does seem to make sense to put graphics drivers in the kernel -
> they're implemented as "device drivers" in every other desktop OS.
> Except MacOS X, where's it's an application layer like glibc, but
> nobody understand OS X yet beyond the hardest of developers.
>
We have the AGP, DRM and framebuffer drivers in the kernel anyway. It would 
make sense to do all the autodetection in kernelspace, and let the info be 
available to the X-server. I would love to kill all the hardware specific 
stuff in /etc/XF86Config, especially the keyboard and mouse stuff that 
belongs in or near the kernel.
