Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbTEESh3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 14:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbTEESh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 14:37:29 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:60829 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261225AbTEESh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 14:37:28 -0400
Date: Mon, 5 May 2003 19:49:07 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David van Hoose <davidvh@cox.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.69
Message-ID: <20030505184907.GA24356@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	David van Hoose <davidvh@cox.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EB602ED.3080207@cox.net> <Pine.LNX.4.44.0305050851080.18785-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305050851080.18785-100000@home.transmeta.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 08:56:41AM -0700, Linus Torvalds wrote:

 > But it only happens with AGP, and a lot of people either don't use it or 
 > run only one X session.

The integrated graphics seemed to be a key too. I test the agpgart
changes I make on a half dozen boxes before asking you to pull them,
and still couldn't reproduce this bug. The only difference was that
I only have boxes without onboard graphics. All of them worked just
fine, and all of them used agp & dri.  Maybe I was hitting the bug,
but the integrated chipsets thrash agpgart a little harder..

		Dave

