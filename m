Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268045AbUIKARn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268045AbUIKARn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 20:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268048AbUIKARm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 20:17:42 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:25569 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268045AbUIKARl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 20:17:41 -0400
Date: Fri, 10 Sep 2004 17:17:13 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386 reduce spurious interrupt noise
Message-ID: <20040911001713.GA902@taniwha.stupidest.org>
References: <20040902192820.GA6427@taniwha.stupidest.org> <Pine.LNX.4.58L.0409102306420.20057@blysk.ds.pg.gda.pl> <20040910231052.GA3078@taniwha.stupidest.org> <Pine.LNX.4.58L.0409110156080.20057@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0409110156080.20057@blysk.ds.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 02:14:13AM +0200, Maciej W. Rozycki wrote:

> These are just as harmless as single-bit RAM errors with ECC
> working.

Hence KERN_DEBUG

> For the former you only really want to rate-limit the report -- some
> people apparently want or need to run broken hardware and they'd
> probably appreciate limiting the output.

A little more than rate-limit as I mentioned.  I don't want the
occasional surious APIC message waking up consoles that are asleep.
This was the reason for the change.


  --cw
