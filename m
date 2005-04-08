Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262682AbVDHENu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbVDHENu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 00:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVDHENu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 00:13:50 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:24290 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262682AbVDHENp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 00:13:45 -0400
Date: Thu, 7 Apr 2005 21:13:41 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050408041341.GA8720@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2005 at 08:42:08AM -0700, Linus Torvalds wrote:

> PS. Don't bother telling me about subversion. If you must, start reading
> up on "monotone". That seems to be the most viable alternative, but don't
> pester the developers so much that they don't get any work done. They are
> already aware of my problems ;)

I'm playing with monotone right now.  Superficially it looks like it
has tons of gee-whiz neato stuff...  however, it's *agonizingly* slow.
I mean glacial.  A heavily sedated sloth with no legs is probably
faster.

Using monotone to pull itself too over 2 hours wall-time and 71
minutes of CPU time.

Arguably brand-new CPUs are probably about 2x the speed of what I have
now and there might have been networking funnies --- but that's still
35 monutes to get ~40MB of data.

The kernel is ten times larger, so does that mean to do a clean pull
of the kernel we are looking at (71/2*10) ~ 355 minutes or 6 hours of
CPU time?

