Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288579AbSAHXjj>; Tue, 8 Jan 2002 18:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288582AbSAHXja>; Tue, 8 Jan 2002 18:39:30 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:17396 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S288579AbSAHXjP>;
	Tue, 8 Jan 2002 18:39:15 -0500
Date: Wed, 9 Jan 2002 00:39:01 +0100
From: David Weinehall <tao@acc.umu.se>
To: Greg KH <greg@kroah.com>
Cc: jtv <jtv@xs4all.nl>, Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__
Message-ID: <20020109003901.T5235@khan.acc.umu.se>
In-Reply-To: <3C3B664B.3060103@intel.com> <20020108220149.GA15816@kroah.com> <20020108235649.A26154@xs4all.nl> <20020108231147.GA16313@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20020108231147.GA16313@kroah.com>; from greg@kroah.com on Tue, Jan 08, 2002 at 03:11:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 03:11:47PM -0800, Greg KH wrote:
> On Tue, Jan 08, 2002 at 11:56:49PM +0100, jtv wrote:
> > 
> > Don't have a C99 spec, but here's what info gcc has to say about it:
> > 
> > [...description of "function names" extension as currently found in gcc...]
> > 
> >    Note that these semantics are deprecated, and that GCC 3.2 will
> > handle `__FUNCTION__' and `__PRETTY_FUNCTION__' the same way as
> > `__func__'.  `__func__' is defined by the ISO standard C99:
> 
> Any reason _why_ they would want to break tons of existing code in this
> manner?  Just the fact that the __func__ symbol is there to use?
> 
> Since the C99 spec does not state anything about __FUNCTION__, changing
> it from the current behavior does not seem like a wise thing to do.
> 
> Any pointers to someone to complain to, or is there no chance for
> reversal?

Because the want people to stop using a gcc-specific way and start
using the C99-mandated way instead?! Very sane imho.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
