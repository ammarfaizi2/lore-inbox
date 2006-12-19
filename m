Return-Path: <linux-kernel-owner+w=401wt.eu-S1752390AbWLSETC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbWLSETC (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 23:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752411AbWLSETC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 23:19:02 -0500
Received: from mail.enter.net ([216.193.128.40]:31061 "EHLO mmail.enter.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390AbWLSETA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 23:19:00 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: davids@webmaster.com
Subject: Re: GPL only modules
Date: Mon, 18 Dec 2006 21:38:25 -0500
User-Agent: KMail/1.9.5
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKKEEOAHAC.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKKEEOAHAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612182138.25332.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 December 2006 20:35, David Schwartz wrote:
> > For both static and dynamic linking, you might claim the output is an
> > aggregate, but that doesn't matter.  What matters is whether or not
> > the output is a work based on the program, and whether the "mere
> > aggregation" paragraph kicks in.
> >
> > If the output is not an aggregate, which is quite likely to be
> > the case for dynamic linking, and quite possibly also for many static
> > linking cases, then the "mere aggregation" paragraph of clause 2 does
> > not kick in.
> >
> > If the output is indeed an aggregate, as it may quite likely be in the
> > case of static linking, then the "mere aggregation" considerations of
> > clause 2 may kick in and enable the 'anything else' to not be brought
> > under the scope of the license.  You still need permission to
> > distribute the whole.  The GPL asserts its non-interference with your
> > ability to distribute the separate portion separately, under whatever
> > license you can, as long as it's not a derived work from the GPL
> > portion.
>
> No!
>
> It makes no difference whether the "mere aggregation" paragraph kicks in
> because the "mere aggregation" paragraph is *explaining* the *law*. What
> matters is what the law actually *says*.
>
> We are talking about what works are within the GPL's scope. The text of the
> GPL does not matter because the GPL does not set its own scope, copyright
> law does.
>
> The GPL could say that if you ever see the source code to a GPL'd work,
> every work you ever write must be placed under the GPL. But that wouldn't
> make it true, because that would be a requirement outside the GPL's scope.
>
> We are talking about works are inside the GPL's legal scope, and in that
> case, nothing the GPL says can enlarge the scope.
>
> DS


Actually, after rereading the GPLv2 because of this discussion I came to a 
most surprising conclusion. While there are *IMPLICIT* and *EXPLICIT* 
copyrights on the code, they have no bearing on the text of the GPL.

The GPL is a License that covers how the code may be used, modified and 
distributed. This is the reason that the FSF people had to make the big 
exception for Bison, because the parser skeleton is such an integral part of 
Bison (Bison itself, IIRC, uses the same skeleton, modified, as part of the 
program) that truthfully, any parser built using Bison is a derivative work 
of code released under the GPL.

That said, since there is a distribution, use and modification license on the 
Linux Kernel - the GPLv2 - there are those extra restrictions on the code 
*OUTSIDE* the copyright rules.

DRH
