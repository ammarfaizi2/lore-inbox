Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbWALHYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbWALHYM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 02:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbWALHYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 02:24:12 -0500
Received: from colo.lackof.org ([198.49.126.79]:34452 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1030287AbWALHYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 02:24:11 -0500
Date: Thu, 12 Jan 2006 00:33:09 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Grant Grundler <grundler@parisc-linux.org>, Mark Maule <maule@sgi.com>,
       Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
       gregkh@suse.de, linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/3] msi vector targeting abstractions
Message-ID: <20060112073308.GA15355@colo.lackof.org>
References: <20060111155251.12460.71269.12163@attica.americas.sgi.com> <20060111155256.12460.26048.32596@attica.americas.sgi.com> <20060112050243.GC332@colo.lackof.org> <17349.60783.236661.875374@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17349.60783.236661.875374@cargo.ozlabs.ibm.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 04:47:27PM +1100, Paul Mackerras wrote:
> Grant Grundler writes:
> 
> > > +	if ((status = msi_arch_init()) < 0) {
> > 
> > Willy told me I should always complain about assignment in if() statements :)
> 
> We are getting incredibly politically correct these days, aren't we.

I'm not asking greg to reject the patch nor dictating Mark Mauler change it.
Since greg is willing to accept a patch to "fix" it, I'm willing to provide 
the patch in this case. I think that's fairly normal way to clean things up.

> I see nothing wrong with that if statement.  It's perfectly valid,
> idiomatic C.  You can ignore Willy if you like. :)

While it is valid C, "=" occasionally gets confused with "==".
And adding unnecessary parens to an if() statement increases the
risk someone will misread the line.  "someone" includes me. :)

> (I would look askance at something that did an assignment as one of
> the parameters of a procedure call in an if statement, though.)

*nod* 

thanks,
grant
