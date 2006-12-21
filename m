Return-Path: <linux-kernel-owner+w=401wt.eu-S1422888AbWLUPfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422888AbWLUPfF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 10:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422899AbWLUPfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 10:35:05 -0500
Received: from bld-mail03.adl2.internode.on.net ([203.16.214.67]:58350 "EHLO
	mail.internode.on.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422888AbWLUPfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 10:35:03 -0500
From: Marek Wawrzyczny <marekw1977@yahoo.com.au>
To: Valdis.Kletnieks@vt.edu
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Date: Fri, 22 Dec 2006 02:34:54 +1100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <MDEHLPKNGKAHNMBLJOLKCEAPAGAC.davids@webmaster.com> <200612192357.45443.marekw1977@yahoo.com.au> <200612200511.kBK5BFo4019459@turing-police.cc.vt.edu>
In-Reply-To: <200612200511.kBK5BFo4019459@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612220234.55313.marekw1977@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 December 2006 16:11, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 19 Dec 2006 23:57:45 +1100, Marek Wawrzyczny said:
> > On Sunday 17 December 2006 21:11, Geert Uytterhoeven wrote:
> > And if you let yourself get carried away, you can also imagine a little
> > multi-platform utility. It would run on a test system collecting PCI IDs
> > before submitting them to the site  to get the system's overall Linux
> > friendliness rating.
>
> This is a can of worms, and then some.  For instance, let's consider this
> Latitude.  *THIS* one has an NVidia Quadro NVS 110M in it.  However, that's
> not the default graphics card on a Latitude D820.  So what number do you
> put in?  Do you use:

No, no, no...  I was never proposing that. I was thinking of something more 
along the lines of reporting back on open-source friendliness of 
manufacturers of devices, and perhaps on the availability of open source 
drivers for the devices. I am talking only about "detected" devices. The 
database would never try and guess the vendor, model and variation of the 
system.

> (Remember that "users" have different criteria than "developers" - most
> users would consider this entire thread "intellectual wanking", especially
> since the patch that spawned it got withdrawn.  And 'Frames Per Second'
> trumps that stupid little 'P' in the oops message.  Failure to understand
> this mindset guarantees that your computation of a "friendliness rating"
> is yet more intellectual wanking... ;)

I actually find that trying to obtain information about what hardware is/isn't 
supported in Linux is actually quite difficult to obtain. The information 
that's on the internet is either outdated or has not yet been written.
I was hoping to analyze the system's device information together with 
driver/device information obtained from the kernel source itself to give 
users a better (but not perhaps not as authoritative as I'd like to) picture 
of what to expect.

> And then there's stuff on this machine that are *not* options, but don't
> matter to me.  I see an 'O2 Micro' Firewire in the 'lspci' output.  I have
> no idea how well it works.  I don't care what it contributes to the score.
> On the other hand, somebody who uses external Firewire disk enclosures may
> be *very* concerned about it, but not care in the slightest about the
> wireless card.

Perhaps we just report on the individual devices then... forget the system 
rating.

> Bonus points for figuring out what to do with systems that have some chip
> that's a supported XYZ driver, but wired up behind a squirrely bridge with
> some totally bizarre IRQ allocation, so you end up with something that's
> visible on lspci but not actually *usable* in any real sense of the term...

Hmmm... does this happen often? False results are definedly a show stopper.
