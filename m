Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTEFOWj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTEFOWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:22:39 -0400
Received: from us02smtp1.synopsys.com ([198.182.60.75]:47269 "HELO
	vaxjo.synopsys.com") by vger.kernel.org with SMTP id S263823AbTEFOWh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:22:37 -0400
Date: Tue, 6 May 2003 16:34:59 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: allow rename to "--bind"-mounted filesystem
Message-ID: <20030506143459.GA25606@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
References: <20030506100435.GH890@riesen-pc.gr05.synopsys.com> <20030506143026.GL10374@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506143026.GL10374@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk, Tue, May 06, 2003 16:30:26 +0200:
> On Tue, May 06, 2003 at 12:04:35PM +0200, Alex Riesen wrote:
> > Hi,
> > i just came over this patch, and wondered why is it missing
> > in both 2.4 and 2.5 (the code in do_rename is identical in both
> > kernels).
> > 
> > Are such renames really not allowed, or was it just fixed differently?
> 
> Such remames are _deliberately_ not allowed.
> 

because that would be against semantics of a mounted filesystem?
(which, in turn, would break something)


