Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275753AbRI0D0b>; Wed, 26 Sep 2001 23:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275754AbRI0D0W>; Wed, 26 Sep 2001 23:26:22 -0400
Received: from pixar.pixar.com ([138.72.10.20]:6289 "EHLO pixar.pixar.com")
	by vger.kernel.org with ESMTP id <S275753AbRI0D0O>;
	Wed, 26 Sep 2001 23:26:14 -0400
Date: Wed, 26 Sep 2001 20:23:24 -0700
From: Kiril Vidimce <vkire@pixar.com>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: max arguments for exec 
In-Reply-To: <8237.1001557672@kao2.melbourne.sgi.com>
Message-ID: <Pine.SGI.4.21.0109262017410.36450-100000@eclipse>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2001, Keith Owens wrote:
> On Wed, 26 Sep 2001 14:25:05 -0700 (PDT), 
> Kiril Vidimce <vkire@pixar.com> wrote:
> >Is there any way to reconfigure the kernel at runtime to change the
> >limit for arguments passed during an exec? I guess I am looking for
> >something similar to systune ncargs under IRIX. I found this thread
> >in the archives:
> >
> >http://uwsg.iu.edu/hypermail/linux/kernel/0003.0/0160.html
> >
> >The only suggestion was to patch and recompile the kernel. I looked
> >into sysctl and I couldn't find an appropriate argument to tweak.
> 
> It is controlled by MAX_ARG_PAGES in include/linux/binfmts.h.  Change
> and recompile the kernel, it is not dynamically tunable in Linux.

Yeah, I know, but we would like to avoid building a custom kernel.
If we do end up going this route, I wonder if there is a limit for 
MAX_ARG_PAGES. Any idea? I think 128 pages (512K) would be sufficient 
for our needs.

KV
--
  ___________________________________________________________________
  Studio Tools                                        vkire@pixar.com
  Pixar Animation Studios                        http://www.pixar.com/

