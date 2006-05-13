Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWEMMXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWEMMXc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 08:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWEMMXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 08:23:32 -0400
Received: from 0x55511dab.adsl.cybercity.dk ([85.81.29.171]:7737 "EHLO
	hunin.borkware.net") by vger.kernel.org with ESMTP id S932408AbWEMMXb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 08:23:31 -0400
From: Mark Rosenstand <mark@borkware.net>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
In-Reply-To: <1147521363.3084.34.camel@gimli.at.home>
References: <20060513103841.B6683146AF@hunin.borkware.net>
	<1147517786.3217.0.camel@laptopd505.fenrus.org>
	<20060513110324.10A38146AF@hunin.borkware.net>
	<1147519329.3084.20.camel@gimli.at.home>
	<20060513114509.3A90D146AF@hunin.borkware.net>
	<1147521363.3084.34.camel@gimli.at.home>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20060513122330.CAA54146AF@hunin.borkware.net>
Date: Sat, 13 May 2006 14:23:30 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Cutting Arjan off the CC list, he's been bugged enough for his attempt
to help.)

Bernd Petrovitsch <bernd@firmix.at> wrote:
> On Sat, 2006-05-13 at 13:45 +0200, Mark Rosenstand wrote:
> > Bernd Petrovitsch <bernd@firmix.at> wrote:
> > > On Sat, 2006-05-13 at 13:03 +0200, Mark Rosenstand wrote:
> > > [...]
> > > > A more useful case is when you setuid the script (and no, this doesn't
> > > > need to be running as root and/or executable by all.)
> > > 
> > > Apart from the permission bug: This has been purposely disabled since it
> > > is way to easy to write exploitable shell or other scripts.
> > > Use a real programming languages, sudo or a trivial wrapper in C ....
> s/languages/language/
> 
> And I forgot to mention that a kernel patch is another possibility.

I'm too stupid to provide such myself, but I'd sure enable the Kconfig
option if it was there :)

> > It isn't a bug on systems that support executable shell scripts.
> 
> I never wrote that (or anything which implies that directly).

I was commenting on the "Apart from the permission bug" part.

> > Doing security policy based on programming language seems weird at
> > best, especially when the only user able to make those decisions is the
> > superuser.
> 
> It boils down to "how easy is it for root to shoot in the foot"?
> And the workarounds are somewhere between trivial and simple.

Or "dare we handle root a gun, it's a powerful weapon but can be used
to shoot at feet." It's obvious what the answer have been for that in
other operating systems, and probably one of the reasons we're here.
