Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270628AbTHOREP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270632AbTHOREP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:04:15 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:4106 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S270628AbTHOREL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:04:11 -0400
Date: Fri, 15 Aug 2003 19:04:08 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Matt Mackall <mpm@selenic.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Val Henson <val@nmt.edu>,
       David Wagner <daw@mozart.cs.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030815190408.A3071@pclin040.win.tue.nl>
References: <20030809173329.GU31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030814165320.GA2839@speare5-1-14> <bhgoj9$9ab$1@abraham.cs.berkeley.edu> <20030815001713.GD5333@speare5-1-14> <20030815093003.A2784@pclin040.win.tue.nl> <20030815150324.GX325@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030815150324.GX325@waste.org>; from mpm@selenic.com on Fri, Aug 15, 2003 at 10:03:24AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 10:03:24AM -0500, Matt Mackall wrote:
> On Fri, Aug 15, 2003 at 09:30:03AM +0200, Andries Brouwer wrote:
> > On Thu, Aug 14, 2003 at 06:17:13PM -0600, Val Henson wrote:
> > 
> > > See Matt Mackall's earlier post on correlation, excerpted at the end
> > > of this message.  Basically, with two strings x and y, the entropy of
> > > x alone or y alone is always greater than or equal to the entropy of x
> > > xored with y.
> > > 
> > > entropy(x) >= entropy(x xor y)
> > > entropy(y) >= entropy(x xor y)
> > 
> > Is this trolling? Are you serious?
> > Try to put z = x xor y and apply your insight to the strings x and z.
> 
> Val left out the assumption that x and y are already perfectly
> distributed, in and of themselves.

I see. "Perfectly distributed" does not sound like a good technical term.
Surely you do not mean "uniformly distributed".
Maybe you mean: "of maximal possible entropy?".

Then the statement has nothing to do with the xor and is just
 entropy(x) >= entropy(a)
assuming that x has maximal possible entropy.

Well, yes, indeed.

