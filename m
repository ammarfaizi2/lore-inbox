Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWEUUt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWEUUt4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 16:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWEUUt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 16:49:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52634 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751347AbWEUUtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 16:49:55 -0400
Date: Sun, 21 May 2006 16:49:47 -0400
From: Dave Jones <davej@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       levon@movementarian.org, phil.el@wanadoo.fr,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Is OPROFILE actively maintained?
Message-ID: <20060521204947.GM8250@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, levon@movementarian.org,
	phil.el@wanadoo.fr, Andrew Morton <akpm@osdl.org>
References: <20060520025322.GD9486@taniwha.stupidest.org> <20060521194915.GA2153@taniwha.stupidest.org> <20060521195710.GL8250@redhat.com> <20060521201720.GA2712@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521201720.GA2712@taniwha.stupidest.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 01:17:20PM -0700, Chris Wedgwood wrote:

 > > BROKEN is for stuff that doesn't compile, or is fundamentally flawed
 > > beyond repair at the current time (For example, needs infrastructure
 > > work to happen before it can work correctly).
 > 
 > Sure, based on my personal experience oprofile works fine, I'm just
 > putting an idea out there given comments from others.
 > 
 > > Oprofile fits neither of those categories.
 > 
 > So it should remain EXPERIMENTAL then in your view?

Part of the problem with EXPERIMENTAL is that it's been taken
to mean all sorts of things over the years from "this isn't quite ready, but works"
to "if you enable this, you're a lunatic".  It's meant that pretty much
everyone has to enable CONFIG_EXPERIMENTAL anyway for a kernel offering
the features everyone has come to expect.  As means of example, I'll bet
there's no (or at least very few) distros that ship a kernel with
CONFIG_EXPERIMENTAL disabled.

		Dave

-- 
http://www.codemonkey.org.uk
