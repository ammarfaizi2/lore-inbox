Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313019AbSDYJuh>; Thu, 25 Apr 2002 05:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313022AbSDYJug>; Thu, 25 Apr 2002 05:50:36 -0400
Received: from [195.163.186.27] ([195.163.186.27]:48517 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S313019AbSDYJuf>;
	Thu, 25 Apr 2002 05:50:35 -0400
Date: Thu, 25 Apr 2002 12:50:34 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Huo Zhigang <zghuo@gatekeeper.ncic.ac.cn>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Re: what`s wrong?
Message-ID: <20020425125034.O1284@mea-ext.zmailer.org>
In-Reply-To: <7754BE8DC82.AAA4CC2@gatekeeper.ncic.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2002 at 05:12:21PM +0800, Huo Zhigang wrote:
...
> >The entire kernel stack is only 8kB in size.  You have already killed
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >a bunch of random memory by allocating this much memory on the stack.
> >You allocated 4*8192 = 32kB on the stack here.
>   
>    Sure, the kernel stack is 8192 Bytes, but "err_frame[]" is a local 
>    variable. Does the kernel allocate memory for "err_frame[]" from the 
>    stack?? 

   It is not about how KERNEL does it, but how C (programming language)
   does it.  If you don't know C's memory management things regarding
   various classes of variables, I suggest you pick some good reference
   book and study it asap.

>    Here, I think, err_frame[] as a function parameter  will take 8K in 
>    the kernel stack.  Am I correct?

  Sorry, this isn't "programming in C"-education forum..

>    Thank you.

/Matti Aarnio
