Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263789AbTEFO5A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbTEFO5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:57:00 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:32419 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP id S263789AbTEFO47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:56:59 -0400
Date: Tue, 6 May 2003 17:09:21 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: allow rename to "--bind"-mounted filesystem
Message-ID: <20030506150921.GA25849@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
References: <20030506100435.GH890@riesen-pc.gr05.synopsys.com> <20030506143026.GL10374@parcelfarce.linux.theplanet.co.uk> <20030506143459.GA25606@riesen-pc.gr05.synopsys.com> <20030506150219.GM10374@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506150219.GM10374@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk, Tue, May 06, 2003 17:02:19 +0200:
> On Tue, May 06, 2003 at 04:34:59PM +0200, Alex Riesen wrote:
> > viro@parcelfarce.linux.theplanet.co.uk, Tue, May 06, 2003 16:30:26 +0200:
> > > On Tue, May 06, 2003 at 12:04:35PM +0200, Alex Riesen wrote:
> > > > i just came over this patch, and wondered why is it missing in
> > > > both 2.4 and 2.5 (the code in do_rename is identical in both
> > > > kernels).
> > > > 
> > > > Are such renames really not allowed, or was it just fixed
> > > > differently?
> > > 
> > > Such remames are _deliberately_ not allowed.
> > 
> > because that would be against semantics of a mounted filesystem?
> > (which, in turn, would break something)
> 
> Binding a subtree creates a sandbox of sorts.  You can bind a bunch of
> subtrees of the same fs into namespace and have normal protection
> against rename and link between them.

sounds useful, even though i can't think of real example of such a use :)

Thank you, that clarifies the behaviour, at least to me.
