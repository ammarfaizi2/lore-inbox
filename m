Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318758AbSG0Nvt>; Sat, 27 Jul 2002 09:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318760AbSG0Nvt>; Sat, 27 Jul 2002 09:51:49 -0400
Received: from dsl-213-023-021-146.arcor-ip.net ([213.23.21.146]:52711 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318759AbSG0Nvs>;
	Sat, 27 Jul 2002 09:51:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [PATCH] lock assertion macros for 2.5.28
Date: Sat, 27 Jul 2002 15:56:08 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <20020725233047.GA782991@sgi.com> <20020726174258.GC793866@sgi.com> <20020726185416.A18629@infradead.org>
In-Reply-To: <20020726185416.A18629@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17YS3I-0005JB-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 July 2002 19:54, Christoph Hellwig wrote:
> On Fri, Jul 26, 2002 at 10:42:58AM -0700, Jesse Barnes wrote:
> > On Fri, Jul 26, 2002 at 04:09:18PM +0400, Joshua MacDonald wrote:
> > > In reiser4 we are looking forward to having a MUST_NOT_HOLD (i.e.,
> > > spin_is_not_locked) assertion for kernel spinlocks.  Do you know if any
> > > progress has been made in that direction?
> > 
> > Well, I had that in one version of the patch, but people didn't think
> > it would be useful.  Maybe you'd like to check out Oliver's comments
> > at http://marc.theaimsgroup.com/?l=linux-kernel&m=102644431806734&w=2
> > and respond?  If there's demand for MUST_NOT_HOLD, I'd be happy to add
> > it since it should be easy.  But if you're using it to enforce lock
> > ordering as Oliver suggests, then there are probably more robust
> > solutions.
> 
> Why don't you just generalize the scsi version that already support this?
> 
> reinventing the wheel everywhere..

The scsi version is stupid.  It panics instead of oopses and it takes two
parameters.

More like improving a wheel, having observed that it works better if its
round.

-- 
Daniel
