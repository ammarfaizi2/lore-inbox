Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317896AbSGZRvF>; Fri, 26 Jul 2002 13:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317898AbSGZRvF>; Fri, 26 Jul 2002 13:51:05 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:12303 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317896AbSGZRvA>; Fri, 26 Jul 2002 13:51:00 -0400
Date: Fri, 26 Jul 2002 18:54:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lock assertion macros for 2.5.28
Message-ID: <20020726185416.A18629@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesse Barnes <jbarnes@sgi.com>, linux-kernel@vger.kernel.org
References: <20020725233047.GA782991@sgi.com> <20020726120918.GA22049@reload.namesys.com> <20020726174258.GC793866@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020726174258.GC793866@sgi.com>; from jbarnes@sgi.com on Fri, Jul 26, 2002 at 10:42:58AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 10:42:58AM -0700, Jesse Barnes wrote:
> On Fri, Jul 26, 2002 at 04:09:18PM +0400, Joshua MacDonald wrote:
> > In reiser4 we are looking forward to having a MUST_NOT_HOLD (i.e.,
> > spin_is_not_locked) assertion for kernel spinlocks.  Do you know if any
> > progress has been made in that direction?
> 
> Well, I had that in one version of the patch, but people didn't think
> it would be useful.  Maybe you'd like to check out Oliver's comments
> at http://marc.theaimsgroup.com/?l=linux-kernel&m=102644431806734&w=2
> and respond?  If there's demand for MUST_NOT_HOLD, I'd be happy to add
> it since it should be easy.  But if you're using it to enforce lock
> ordering as Oliver suggests, then there are probably more robust
> solutions.

Why don't you just generalize the scsi version that already support this?

reinventing the wheel everywhere..

