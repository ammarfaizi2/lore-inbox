Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbVKORrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbVKORrE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbVKORrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:47:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:26272 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751467AbVKORrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:47:01 -0500
Date: Tue, 15 Nov 2005 09:33:07 -0800
From: Greg KH <gregkh@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] HOWTO do Linux kernel development
Message-ID: <20051115173307.GB13707@suse.de>
References: <20051114220709.GA5234@kroah.com> <p73veyu2crf.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73veyu2crf.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 03:42:44PM +0100, Andi Kleen wrote:
> Greg KH <gregkh@suse.de> writes:
> 
> > The kernel is written using GNU C and the GNU toolchain. While it
> > adheres to the ISO C99 (??) standard, it uses a number of extensions
> 
> C89 - The few left over gcc 2.95 users are blocking modern C constructs.
> Even without that it would be a C99 subset, e.g. arbitary long long divisions 
> or floating point are not supported.
> 
> Also the kernel is a freestanding C environment, so parts are not supported.

Thanks, I've modified it to mention this.

> > Also realize that it is not acceptable to send patches for inclusion
> > that are unfinished and will be "fixed up later."
> 
> I'm not sure I fully agree on that. I conflicts with the "merge early, merge
> often" imperative.  IMHO it's ok to submit patches that are not perfect,
> but improve something or make a incremental cleanup step, as long as the
> problems are not severe and the patch by itself is a clear improvement. Of course
> this is handled on a case by case basis.

Yeah, it is a case-by-case, but generally we want to know up front what
the final result is going to be.

> > Justify your change
> > -------------------
> > 
> > Along with breaking up your patches, it is very important for you to let
> > the Linux community know why they should add this change.  New features
> > must be justified as being needed and useful.
> 
> My request is that each patch should carry a meaningful changelog.
> That should tell why and a rough (doesn't need to be detailed) overview how
> the change is done.

Others privately commented on this too, and I've added a section
describing it.

Thanks for the comments.

greg k-h
