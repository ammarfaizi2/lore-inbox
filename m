Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262302AbTCTUmo>; Thu, 20 Mar 2003 15:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262304AbTCTUmo>; Thu, 20 Mar 2003 15:42:44 -0500
Received: from havoc.daloft.com ([64.213.145.173]:28374 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S262302AbTCTUmn>;
	Thu, 20 Mar 2003 15:42:43 -0500
Date: Thu, 20 Mar 2003 15:53:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Subject: Re: Release of 2.4.21
Message-ID: <20030320205338.GG8256@gtf.org>
References: <20030320195657.GA3270@drcomp.erfurt.thur.de> <874r5xyeky.fsf@sdbk.de> <20030320203407.GF8256@gtf.org> <20030320204218.A18517@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320204218.A18517@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 08:42:18PM +0000, Christoph Hellwig wrote:
> On Thu, Mar 20, 2003 at 03:34:07PM -0500, Jeff Garzik wrote:
> > For critical fixes, release a 2.4.20.1, 2.4.20.2, etc.  Don't disrupt
> > the 2.4.21-pre cycle, that would be less productive than just patching
> > 2.4.20 and rolling a separate release off of that.
> 
> I think the naming is illogical.  If there's a bugfix-only release

Many, many companies seem to find it logical.  If you want to squeeze
a version in between "1" and "2".

Further, other kernel hackers suggested the 2.4.20.N sequence,
I simply agreed with it.  So it's not only me who thinks this way :)


> it whould have normal incremental numbers.  So if marcelo want's
> it he should clone a tree of at 2.4.20, apply the essential patches
> and bump the version number in the normal 2.4 tree to 2.4.22-pre1

Human nature says that will drag out the -pre tree ad infinitum.
Suppose a 2.4.21 is released today, with 2.4.20 + bug fixes.  Now,
tomorrow, another "critical bug" comes out, and then the -pre tree
becomes 2.4.23-pre.  Add another critical bug, and I hope you see
the continual delay of -pre happens here...

The basic logic is "do not disrupt current plans.  Do something
_in addition to_ current plans."

	Jeff



