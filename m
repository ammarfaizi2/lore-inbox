Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbRFNHx5>; Thu, 14 Jun 2001 03:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261394AbRFNHxr>; Thu, 14 Jun 2001 03:53:47 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:43025 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261390AbRFNHxm>; Thu, 14 Jun 2001 03:53:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: David Luyer <david_luyer@pacific.net.au>, "Rainer Mager" <rmager@vgkk.com>
Subject: Re: Download process for a "split kernel" (was: obsolete code must die)
Date: Thu, 14 Jun 2001 09:56:17 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGCEFCEEAA.rmager@vgkk.com> <200106140200.f5E20NL3012987@typhaon.pacific.net.au>
In-Reply-To: <200106140200.f5E20NL3012987@typhaon.pacific.net.au>
MIME-Version: 1.0
Message-Id: <01061409561702.00879@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 June 2001 04:00, David Luyer wrote:
> > Would it make sense to create some sort of 'make config' script that
> > determines what you want in your kernel and then downloads only those
> > components? After all, with the constant release of new hardware, isn't a
> > 50MB kernel release not too far away? 100MB?
>
> This might actually make sense - a kernel composed of multiple versioned
> segments.  A tool which works out dependencies of the options being
> selected, downloads the required parts if the latest versions of those
> parts are not already downloaded, and then builds the kernel...

This sounds a lot like apt-get, doesn't it?

> ... (or could even
> build during the download, as soon as the build dependencies for each block
> of the kernel are satisfied, if you want to be fancy...).

This is fancier alright:

  1) walk
  2) run

It's the kind of power tool that will be pretty easy to graft onto ESR's new 
cml2 code base.  I'd love to see better apt-get hooks into the kernel 
config/download/build/install.

--
Daniel
