Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291863AbSBXXpn>; Sun, 24 Feb 2002 18:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291869AbSBXXpf>; Sun, 24 Feb 2002 18:45:35 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:36589 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S291863AbSBXXpR>; Sun, 24 Feb 2002 18:45:17 -0500
Date: Sun, 24 Feb 2002 16:45:08 -0700
Message-Id: <200202242345.g1ONj8m29970@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jes Sorensen <jes@sunsite.dk>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] C exceptions in kernel
In-Reply-To: <d3it8nr8tq.fsf@lxplus049.cern.ch>
In-Reply-To: <927.1014507655@ocs3.intra.ocs.com.au>
	<d3it8nr8tq.fsf@lxplus049.cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen writes:
> Keith Owens <kaos@ocs.com.au> writes:
> 
> > So you have arch dependent code which has to be done for all
> > architectures before any driver can use it and the code has to be kept
> > up to date by each arch maintainer.  Tell me again why the existing
> > mechanisms are not working and why we need exceptions?  IOW, what
> > existing problem justifies all the extra arch work and maintenance?
> 
> Sorry, can't tell you why as I agree wholeheartedly with you. My
> point was that even if it was possible to implement exceptions 'for
> free' on all architectures, then it's still not what we want in the
> kernel. It's just too gross and makes people think about the code
> the wrong way.

This seems worthy of a new FAQ entry: http://www.tux.org/lkml/#s15-5
And while I was at it, I moved a bunch of these religious questions
into their own section. Section 1 is a bit of a hodge-podge.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
