Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265337AbSJXHEA>; Thu, 24 Oct 2002 03:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265338AbSJXHEA>; Thu, 24 Oct 2002 03:04:00 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:56754 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265337AbSJXHD6>;
	Thu, 24 Oct 2002 03:03:58 -0400
Date: Thu, 24 Oct 2002 12:53:18 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Rob Landley <landley@trommello.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Son of crunch time: the list v1.2.
Message-ID: <20021024125318.B30624@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <3DB4B1B9.4070303@pobox.com> <20021023155853.A28909@in.ibm.com> <200210231103.20711.landley@trommello.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210231103.20711.landley@trommello.org>; from landley@trommello.org on Wed, Oct 23, 2002 at 11:03:20AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 11:03:20AM -0500, Rob Landley wrote:
> On Wednesday 23 October 2002 05:28, Vamsi Krishna S . wrote:
> 
> > We are not proposing the entire dprobes patch to be in kernel. It doesn't
> > have to be. We are proposing for inclusion the "kprobes" patchset at
> > http://www-124.ibm.com/linux/patches/?project_id=141 which provides
> > the basic infrastructure in the kernel for setting up and handling
> > breakpoints automatically in kernel space. Once this small piece is in,
> > we can implement comprehensive tools like dynamic probes as external
> > kernel modules without having to patch the kernel.
> 
> Okay, so if patch 1 is kprobes itself, what exactly is the status of patches 
> 2-4?  (Optional but nice?  Cleanups?  Or are you pushing as hard for them as 
> for part 1?)
> 
2-4 are additional features which are required to implement a tool like
dprobes. It is nice to have them all in the kernel, so full-featured tools
like dprobes could be built without touching the kernel.

> I thought 2-4 paved the way for dprobes, but if you're not trying to get 
> dprobes in...?
> 
dprobes doesn't have to be in the mainline kernel, but dprobes (or
any such tool) requires some basic support from the kernel for setting
up breakpoints. kprobes provides these fundamental facilities which
are useable as-is.

Thanks,
Vamsi.

-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
