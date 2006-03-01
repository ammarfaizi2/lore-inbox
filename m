Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932642AbWCAAkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbWCAAkW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 19:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbWCAAkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 19:40:22 -0500
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:16631 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932642AbWCAAkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 19:40:22 -0500
Date: Tue, 28 Feb 2006 16:40:39 -0800
From: Deepak Saxena <dsaxena@plexity.net>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de
Subject: Re: [PATCH] Generic hardware RNG support
Message-ID: <20060301004039.GA14229@plexity.net>
Reply-To: dsaxena@plexity.net
References: <200602281229.12887.mbuesch@freenet.de> <44043CEE.70201@pobox.com> <200602281311.59888.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602281311.59888.mbuesch@freenet.de>
Organization: Plexity Networks
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 28 2006, at 13:11, Michael Buesch was caught saying:
> On Tuesday 28 February 2006 13:07, you wrote:
> > Michael Buesch wrote:
> > > Andrew, consider inclusion of the following patch into -mm
> > > for further testing, please.
> > > 
> > > ---
> > > 
> > > This patch adds support for generic Hardware Random Number Generator
> > > drivers. This makes the usage of the bcm43xx internal RNG through
> > > /dev/hwrandom possible.
> > > 
> > > A patch against bcm43xx for your testing pleasure can be found at:
> > > ftp://ftp.bu3sch.de/misc/bcm43xx-d80211-hwrng.patch
> > 
> > Please merge with Deepak Saxena's generic RNG stuff, rather than 
> > duplicating efforts.
> 
> Well, I did not know that someone else already wrote something
> like this. Do you have any pointers to his stuff (patches)?

Hi, I'll email you the patchset off-list so you can look at the API
and write the bcm43xx driver against it.  They are a few months old and 
need updating to 2.6.latest and it is on my 2.6.18 TODO. If you search the
archives there were a few small issues left such as separating out all the
x86 stuff into separate amd, via, and intel code instead of having a single
file.

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

A starving child in Africa or you in front of your TV?
Where's the real tragedy?
