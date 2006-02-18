Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWBRXaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWBRXaE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 18:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWBRXaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 18:30:03 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:46542
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932279AbWBRXaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 18:30:01 -0500
Date: Sat, 18 Feb 2006 15:29:34 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       Christoph Hellwig <hch@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, openib-general@openib.org,
       SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Subject: Re: [PATCH 02/22] Firmware interface code for IB device.
Message-ID: <20060218232934.GA2624@kroah.com>
References: <20060218015808.GB17653@kroah.com> <aday809bewn.fsf@cisco.com> <20060218122011.GE911@infradead.org> <20060218122631.GA30535@granada.merseine.nu> <1140265955.4035.19.camel@laptopd505.fenrus.org> <adazmkoaaqr.fsf@cisco.com> <20060218181509.GA892@kroah.com> <adavevca48l.fsf@cisco.com> <20060218195327.GA1382@kroah.com> <adar7609wvr.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adar7609wvr.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 01:31:52PM -0800, Roland Dreier wrote:
>     Greg> Sorry, I didn't mean to say "private", but rather,
>     Greg> "seperate".  Doing kernel development in a seperate
>     Greg> development tree from the mainline kernel is very
>     Greg> problematic, as has been documented many times in the past.
> 
> As a general rule I agree with that.  However, the openib svn tree
> we're talking about is not some project that is off in space never
> merging with the kernel; as Christoph said, it's really just a staging
> area for stuff that isn't ready for upstream yet.n
> 
> Perhaps it would be more politically correct to use git to develop
> kernel code, but in the end that's really just a technical difference
> that shouldn't matter.

Yes, that doesn't matter.  But it seems that the svn tree is vastly
different from the in-kernel code.  So much so that some companies feel
that the in-kernel stuff just isn't worth running at all.

>     Roland> Distro politics are just distro politics -- and there will
>     Roland> always be pressure on distros to ship stuff that's not
>     Roland> upstream yet.
> 
>     Greg> Luckily the distros know better than to accept this anymore,
>     Greg> as they have been burned too many times in the past...
> 
> OK, that's great.  But now I don't understand your original point.
> You say there are people putting pressure on distros to ship what's in
> openib svn rather than the upstream kernel, but if the distros are
> going to ignore them, what does it matter?

It takes a _lot_ of effort to ignore them, as it's very difficult to do
so.  Especially when companies try to play the different distros off of
each other, but that's not an issue that the mainline kernel developers
need to worry about :)

> And this thread started with me trying to help the IBM people make
> progress towards merging a big chunk of that svn tree upstream.  That
> should make you happy, right?

Yes, that does make me happy.  But it doesn't make me happy to see IBM
not being able to participate in kernel development by posting and
defending their own code to lkml.  I thought IBM knew better than
that...

thanks,

greg k-h
