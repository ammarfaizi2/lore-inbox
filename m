Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVCISlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVCISlP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVCIShn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:37:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:4288 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262162AbVCISeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:34:25 -0500
Date: Wed, 9 Mar 2005 10:34:08 -0800
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@muc.de>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050309183408.GB26902@kroah.com>
References: <20050309072833.GA18878@kroah.com> <m1sm35w3am.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1sm35w3am.fsf@muc.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 10:56:33AM +0100, Andi Kleen wrote:
> Greg KH <greg@kroah.com> writes:
> >
> > Rules on what kind of patches are accepted, and what ones are not, into
> > the "-stable" tree:
> >  - It must be obviously correct and tested.
> >  - It can not bigger than 100 lines, with context.
> 
> This rule seems silly. What happens when a security fix needs 150 lines? 

Then we bend the rules and accept it :)

We'll take these as a case-by-case basis...

> >  - Security patches will be accepted into the -stable tree directly from
> >    the security kernel team, and not go through the normal review cycle.
> >    Contact the kernel security team for more details on this procedure.
> 
> This also sounds like a bad rule. How come the security team has more
> competence to review patches than the subsystem maintainers?  I can
> see the point of overruling maintainers on security issues when they
> are not responsive, but if they are I think the should be still the
> main point of contact.

Security fixes go from the security team to Linus's tree directly, and
usually the subsystem maintainer has already been notified and has
reviewedit.  At that point in time, they are public and accepted into
mainline, and need to be made availble to the -stable users as soon as
possible.

That is why the "fast track" is going to happen, the patch really was
reviewed properly, just not in public :)

thanks,

greg k-h
