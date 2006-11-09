Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424059AbWKIPeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424059AbWKIPeF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424063AbWKIPeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:34:04 -0500
Received: from cantor2.suse.de ([195.135.220.15]:39888 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1424059AbWKIPeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:34:01 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [Xen-devel] Re: [PATCH] shorten the x86_64 boot setup GDT to what the comment says
Date: Thu, 9 Nov 2006 14:31:44 +0100
User-Agent: KMail/1.9.1
Cc: "Steven Rostedt" <rostedt@goodmis.org>, herbert@gondor.apana.org.au,
       xen-devel@lists.xensource.com, "LKML" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0611082144410.17812@gandalf.stny.rr.com> <200611091413.21415.ak@suse.de> <455357C9.76E4.0078.0@novell.com>
In-Reply-To: <455357C9.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611091431.44792.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 November 2006 16:31, Jan Beulich wrote:
> >>> Andi Kleen <ak@suse.de> 09.11.06 14:13 >>>
> >>
> >> Stephen Tweedie has written up a patch to fix the Xen side and will be
> >> submitting that to those folks. But that doesn't excuse the GDT limit
> >> being a magnitude too big.
> >
> >Added thanks
>
> Once at this - why not set it to the *correct* value, just like i386 does,
> and update the comment at once? Namely, why would you expect to
> never run into the original problem again if there are still possible
> selectors pointing into invalid, yet within limits parts of the GDT?

Ok I will use an offset.

-Andi
