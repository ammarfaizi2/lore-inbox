Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289493AbSALAFb>; Fri, 11 Jan 2002 19:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289833AbSALAFQ>; Fri, 11 Jan 2002 19:05:16 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:25771 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S289493AbSALAE5>; Fri, 11 Jan 2002 19:04:57 -0500
Date: Fri, 11 Jan 2002 16:04:59 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Dan Kegel <dank@kegel.com>, "Timothy D. Witham" <wookie@osdl.org>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Mike Galbraith <mikeg@wen-online.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <stp@osdl.org>
Subject: Re: Regression testing of 2.4.x before release?
In-Reply-To: <E16PAuX-0002Ob-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0201111600560.19843-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2002, Daniel Phillips wrote:

> On November 12, 2001 07:24 am, Dan Kegel wrote:
> > At some point it might be nice to also use the STP to help speed gcc
> > 3 development, too.  (I personally am really looking forward to the
> > day when I can use the same compiler for both c++ and kernel.)
>
> You already can, at least I can because gcc3 builds recent kernels
> just fine.  IOW, it works for me.  Conservatively, it's good to keep
> the old compiler around (choose your poison) for those few apps that
> don't build with gcc, but I feel quite comfortable at the moment
> having gcc3 as my default.

One particular application for which gcc 3.x *and* gcc 2.96.x are
seriously deficient, at least on Intel/AMD 32-bit systems, is the
high-performance linear algebra library Atlas. As a result, *my* default
for compiling numerical applications is the Atlas-recommended one,
2.95.3. For the kernel, I use whatever the Red Hat 7.2 default is.
-- 
M. Edward Borasky
znmeb@borasky-research.net

The COUGAR Project
http://www.borasky-research.com/Cougar.htm

I brought my inner child to "Take Your Child To Work Day."

