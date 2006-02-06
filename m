Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWBFTCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWBFTCt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWBFTCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:02:48 -0500
Received: from smtp.uaf.edu ([137.229.34.30]:30730 "EHLO smtp.uaf.edu")
	by vger.kernel.org with ESMTP id S932180AbWBFTCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:02:48 -0500
From: Joshua Kugler <joshua.kugler@uaf.edu>
Organization: UAF Center for Distance Education - IT
To: linux-kernel@vger.kernel.org
Subject: Re: Linux drivers management
Date: Mon, 6 Feb 2006 10:02:27 -0900
User-Agent: KMail/1.7.2
Cc: Nicolas Mailhot <nicolas.mailhot@laposte.net>,
       David Chow <davidchow@shaolinmicro.com>
References: <1139250712.20009.20.camel@rousalka.dyndns.org>
In-Reply-To: <1139250712.20009.20.camel@rousalka.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602061002.27477.joshua.kugler@uaf.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 09:31, Nicolas Mailhot wrote:
> > I think I am in a different position like you guys, I've been work with
> > Linux from programmer level to Linux promotion . My goal is not just
> > focus on Linux technical or programming, I would like to promote this
> > operating system to not just for programmers, but also non-technical
> > end-users .
>
> Since you invoke end-users I'll answer.

I heartily agree with this!!

I use two products that use out-of-tree drivers.  VMWare and NVidia cards.  
Fortunately, the build processes for both are rather painless, but there have 
been times when it has *not* been, and it was extremely frustrating.  I 
remember when VMWare was not doing a good job of supporting 2.6 kernels and I 
spent the better part of two days trying to track down a solution.  I finally 
did, but it was a third party, non-VMWare, patch to the VMWare code that 
fixed it so it would compile and run.  That's not what I consider convenience 
for the non-technical user.  A non-technical user would not have been able to 
do what I did, especially when they just want their software to work.

> Do you really think we enjoy clicking though boatloads of HTML/js/flash
> forms that will inform us about vastly important things like your custom
> license, the mirror list you want us to master or your dog's birthday ?

I want to install my machine and have everything work.  Don't make me chase 
all over the net trying to find a driver for my hardware.  If it's a network 
(i.e. ethernet device) the driver had *better* be in the tree.  Trying to 
download the driver to another computer, transferring, etc, is enough to make 
me find another brand of network card.

> Do you really think we enjoy learning all your out-of-tree driver
> release and build processes because you couldn't be bothered with using
> the same one as the kernel ?

Latest kernel == latest driver.  No need for me to try to keep all my drivers 
up to date.

> Do you really think we enjoy locating the patch that will "fix" your
> driver for our kernel because you do not bother testing anything else
> than a few kernel releases, and that only for a few months after a you
> wrote your driver ?

See comment about VMWare above.

> Do you really think we enjoy leaving in fear of a system update because
> the first thing to break will be your out-of-tree drivers ?

I sometimes delay kernel updates because I don't want to mess with updating my 
NVidia and VMWare drivers.  This is *not* good for security.

> But do not invoke end-users. Or end users will answer you.

So I did.  Please put your driver in the tree.  It will be better for all 
concerned.

j----- k-----

-- 
Joshua Kugler                 PGP Key: http://pgp.mit.edu/
CDE System Administrator             ID 0xDB26D7CE
http://distance.uaf.edu/
