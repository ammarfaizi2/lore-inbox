Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWIYR1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWIYR1J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 13:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWIYR1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 13:27:09 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:44733 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751317AbWIYR1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 13:27:07 -0400
Subject: Re: GPLv3 Position Statement
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Michiel de Boer <x@rebelhomicide.demon.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <451798FA.8000004@rebelhomicide.demon.nl>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
	 <451798FA.8000004@rebelhomicide.demon.nl>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 13:26:55 -0400
Message-Id: <1159205215.3463.53.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-25 at 10:53 +0200, Michiel de Boer wrote:
> What is the stance of the developer team / kernel maintainers on DRM,
> Trusted Computing and software patents? Does the refusal to adopt GPLv3 as
> is mean that these two are more likely to emerge as supported functionality
> in the Linux kernel? Are there any moral boundaries Linux kernel developers
> will not cross concerning present and new U.S. laws on technology? Are they
> willing to put that in writing? Will Linux support HD-DVD and BluRay by
> being slightly more tolerant to closed source binary blobs? What about
> the already existant problems with the Content Scrambling System for
> DVD's?

Well, I think the email you quoted above gave the stance on DRM as used
by the content industry (in the bit you snipped):

> ... we find the use of DRM by media companies in their attempts to
> reach into user owned devices to control content deeply disturbing

I'll venture my personal opinion of replacing "deeply disturbing" with
"abhorrent".  The trusted computing platform insofar as it is an agent
of that same DRM use by the media companies would thus share that
opinion.  However, if it were sold as an agent at the disposal of the
user of the machine (rather than the content providers) then it
wouldn't.  These technologies are not intrinsically "evil" it's the use
to which they're put that can be.

As far as the you must be able to run modifications language goes:  too
many embedded devices nowadays embed linux.  To demand a channel for
modification is dictating to manufacturers how they build things.  Take
the case of an intelligent SCSI PCI card which happens to run embedded
linux in flash.  The v3 draft requirements dictate a channel to modify
the flash image ... if that's a PCI card, the manufacturer has no
earthly way to control what happens on the platform into which its
plugged.  So, if it's soldered onto a sparc motherboard and the card
manufacturer though their responsibility was discharged by producing a
dos flash floppy, who just broke the v3 requirements? should the sparc
motherboard maker care what embedded OS all the components run? should
the price for using linux to make embedded components be that you have
to provide modification toolkits for every conceivable platform they
could be used in?

Also, I just don't accept that Tivo is bad for Linux (even if I could be
persuaded that attacking Tivo would somehow help the battle against the
content providers' DRM efforts).  I admit that not much useful has come
out of that one company, but the no tampering with the image requirement
came from cable companies who saw modifying a Tivo to store and
redistribute content to be a threat to them.  There's a much more
clearcut example than Tivo:  the Moxi (its rival), which has identical
bootloader requirements forced on it by cable companies for identical
reasons.  It's produced by Digeo who, according to my personal count,
provided us with several device driver updates, a slew of filesystem
improvements and a kernel maintainer (which, I think everyone will
agree, went beyond their strict GPLv2 requirements)... how does some
perceived inequity with Tivo justify killing Digeo? or even making life
difficult for embedded hardware manufacturers?  Look at it this way:
every Tivo is a potential Digeo ... we just have to persuade them.

James


