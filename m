Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUD0W7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUD0W7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 18:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbUD0W7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 18:59:37 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:64404 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S264389AbUD0W71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 18:59:27 -0400
Date: Wed, 28 Apr 2004 00:59:23 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: Michael Poole <mdpoole@troilus.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <878ygh147m.fsf@sanosuke.troilus.org>
Message-ID: <Pine.LNX.4.44.0404280036330.13769-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Michael Poole wrote:

> "Robert M. Stockmann" <stock@stokkie.net> writes:
> 
> [snip]
> > To be more specific about what i am complaining about, here's a 
> > error message i get when doing ./configure inside ntfsprogs-1.8.4 :
> >
> > checking version of gcc... 2.95.3, bad
> > configure: error: Please upgrade your gcc compiler to gcc-2.96+ or gcc-3+ 
> > version! Earlier compiler versions will NOT work as these do not support 
> > unnamed/annonymous structures and unions which are used heavily in linux-ntfs.
> > [jackson:stock]:(~/src/ntfsprogs-1.8.4)$
> >
> > Aha, unnamed/annonymous structures and unions .....
> 
> Please keep rants about applications' coding style where they belong:
> off the linux-kernel list.  If you bothered to READ what Linus wrote,
> you would see that the structure being defined has a name -- in fact,
> gcc requires that, since the structure would be defined at file scope
> rather than inside another structure or union.
> 
> Michael

Hi Michael,

look i have made complaints about gcc-3.x some time ago, on the gcc
mailinglist. Also there they put my opinions aside, with arguments
like any powerfull feature can be used in a bad and in a good way. 
The powerfull feature here is the C99 coding style, which allows for 
unnamed and anonymous structures and unions. Don't kill our C99 cause it
can do bad things. Of course not.

However when dealing with OEM hardware vendors, which have signed contracts
with Microsoft about windows drivers, i think we cannot allow these same
OEM hardware vendors to introduce binary only drivers of unknown quality into
the linux kernel. Its exactly these events which give the Linux kernel, or
even Linux in general, give a bad reputation. Think about rants like this  :

"The Promise FastTrak TX4000 IDE-RAID controller works perfect inside Windows,
 but inside Linux i even lost my data."

The Promise Fasttrak issue i discussed here :

http://gcc.gnu.org/ml/gcc/2004-02/msg00293.html

If every major hardware vendor (like e.g. Adaptec, LSI Logic) will change
its policy, to implement its drivers as semi- binary only kernel modules, like
Promise did with its FastTrak line of controllers, like in the example above,
the Open Source lable of the linux kernel can be placed into the computer
museum. Isn't that exactly what a certain Redmond software company wants
to achieve?

Cheers,

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

