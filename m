Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbTBTMsh>; Thu, 20 Feb 2003 07:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbTBTMsg>; Thu, 20 Feb 2003 07:48:36 -0500
Received: from cal003100.student.utwente.nl ([130.89.160.36]:12231 "EHLO
	margo.student.utwente.nl") by vger.kernel.org with ESMTP
	id <S265409AbTBTMsD>; Thu, 20 Feb 2003 07:48:03 -0500
Date: Thu, 20 Feb 2003 13:58:08 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x release process comments
Message-ID: <20030220125808.GA11694@margo.student.utwente.nl>
Mail-Followup-To: simon, linux-kernel@vger.kernel.org
References: <20030220102404.GA10138@margo.student.utwente.nl> <200302201056.h1KAuwui000635@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302201056.h1KAuwui000635@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4i
From: Simon Oosthoek <simon@margo.student.utwente.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 10:56:58AM +0000, John Bradford wrote:
> > - Kernel version releases (and -pre releases) do not happen often enough to
> > keep up with recent hardware
> > 
> Distributions typically use modified versions of the standard kernel
> anyway.  The kernel development schedule has never been based around
> the needs of any particular distribution or distributions.

I'm not saying it should, but it would be good from a PR perspective and as
an element in the reliability feeling vector ;-)
 
> > I'd love to see regular (say once a week) releases -preX releases and no
> > more than 10 -pre releases before a -rc. No more than 4 -rc's (released no
> > more than 2 weeks apart) before a new version. Faster full version releases
> > would also be fine with me.
> 
> It doesn't make sense to limit the number of -pre releases and release
> candidates - they are needed to make sure, as far as possible, that
> the actual release is stable.

The number of -pre releases shouldn't be limited for its own sake, but
rather in the process of stabilising the kernel for release. So I mean after
a couple of -pre releases start focussing on debugging and then finish with
a few -rc's before the next cycle starts. That way the diffs between full
versions are smaller and upgrading gets easier.
 
> > My personal interest in this is that my laptop is not yet working 100%...
> > (see http://margo.student.utwente.nl/simon/ongoing/jade8060.php)
> 
> I had a quick look, and it looks like it's 95% working, though :-).

yup, I'm getting there :-) Would be nice to have the smartcard reader
working as well... Some things I can't test because I don't have the
hardware (IEEE1394, wireless lan, irda). power management is still quite
magical to me though ;-)

Cheers

Simon
