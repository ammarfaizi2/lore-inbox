Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265552AbTIDVRA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265551AbTIDVRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:17:00 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:5109 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265553AbTIDVQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:16:55 -0400
From: James Clark <jimwclark@ntlworld.com>
Reply-To: jimwclark@ntlworld.com
To: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Date: Thu, 4 Sep 2003 22:16:03 +0100
User-Agent: KMail/1.5
References: <1062637356.846.3471.camel@cube> <200309042114.45234.jimwclark@ntlworld.com> <20030904202707.GF13676@matchmail.com>
In-Reply-To: <20030904202707.GF13676@matchmail.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309042216.03958.jimwclark@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree that at first sight the two concepts (Binary 'plugins' and GPL) don't 
mix well but this is actually FUD which obscures the issue of making the 
kernel much easier to deal with for the masses. Like it or not, 99+% of 
'potential users' don't want/need to recompile their whole kernel, with the 
risks that it has, to add one minor feature.

James


On Thursday 04 Sep 2003 9:27 pm, Mike Fedyk wrote:
> On Thu, Sep 04, 2003 at 09:14:45PM +0100, James Clark wrote:
> > Thank you for this (and the few other) sensible appraisal of my
> > 'proposal'.
> >
> > I'm very surprised by the number of posts that have ranted about
> > Open/Close source, GPL/taint issues etc. This is not about source code it
> > is about making Linux usable by the masses. It may be technically
> > superior to follow the current model, but if the barrier to entry is very
> > high (and it is!) then the project will continue to be a niche project. A
> > binary model doesn't alter the community or the benefits of public source
> > code. I agree that it is an extra interface and will carry a performance
> > hit - I think this is worth it.
>
> The thing is, most Linux developers (and I'm sure it's above 51% or maybe
> they're just louder?) want drivers to be GPL compatible open source. 
> Having a static binary driver interface just doesn't mix very well for
> that.  And as things happen (and how it should be), in a well kept stable
> series, the binary interfaces won't change that much.  But it will change
> for different options, like SMP, preempt, numa, etc.
>
> > Windows has many faults but drivers are often compatible across major
> > releases and VERY compatible across minor releases. It is no accident
> > that it has 90% of the desktop market. If we are going to improve this
> > situation this issue MUST be confronted.
>
> Have you ever seen the source code available for a windows driver?  Windows
> doesn't let you customize the kernel.  You just get what they give you.
> With the customization possible in Linux you get many advantages, and the
> disadvantage that the binary interface can change depending on the compile
> options.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

