Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264994AbTFCNKN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 09:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264998AbTFCNKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 09:10:13 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:26784 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264994AbTFCNJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 09:09:35 -0400
Date: Tue, 3 Jun 2003 14:26:46 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: David van Hoose <davidvh@cox.net>
Cc: Margit Schubert-While <margitsw@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21rc6-ac2
Message-ID: <20030603132646.GA15318@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	David van Hoose <davidvh@cox.net>,
	Margit Schubert-While <margitsw@t-online.de>,
	linux-kernel@vger.kernel.org
References: <5.1.0.14.2.20030603143135.00ae9d40@pop.t-online.de> <3EDC9B6B.3000809@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EDC9B6B.3000809@cox.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 08:58:19AM -0400, David van Hoose wrote:
 > Margit Schubert-While wrote:
 > >Alan, a few things that I think should be in (and for the next rc ?) -
 > >1) Force inline for >= gcc 3.3
 > >2) -march=  for pentium3/4
 > >3) Radeon 9k support
 > >4) Junk the chipset id'ing in agp_support.h
 > >     (Not in DRI/DRM mainline and not in 2.5)
 > >Margit
 > 
 > I agree on the march support. I've been using my own trivial patch for 
 > the i386 Makefile to have direct support for the P3 and P4. Just trying 
 > to figure out whether adding sse2 support on the compile line will 
 > create problems. GCC does not use SSE(2) unless you explicitly tell it to.

and should only make a difference for floating point code.
Which the kernel doesn't use.

This was brought up a few weeks back on the list.

		Dave

