Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWEUT51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWEUT51 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWEUT51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:57:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45704 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964925AbWEUT50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:57:26 -0400
Date: Sun, 21 May 2006 15:57:10 -0400
From: Dave Jones <davej@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       levon@movementarian.org, phil.el@wanadoo.fr,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Is OPROFILE actively maintained?
Message-ID: <20060521195710.GL8250@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, levon@movementarian.org,
	phil.el@wanadoo.fr, Andrew Morton <akpm@osdl.org>
References: <20060520025322.GD9486@taniwha.stupidest.org> <20060521194915.GA2153@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521194915.GA2153@taniwha.stupidest.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 12:49:15PM -0700, Chris Wedgwood wrote:
 > On Fri, May 19, 2006 at 07:53:22PM -0700, Chris Wedgwood wrote:
 > 
 > > oprofile isn't new and a lot of developers use it.  Drop the
 > > EXPERIMENTAL.
 > 
 > Some feedback claims this is not the case and that "it's unmaintained,
 > rarely well-tested, and may still need changes for some forthcoming
 > JVM stuff. and the tools aren't yet at 1.0".
 > 
 > Given that it should probably stay EXPERIMENTAL for now.  I wonder if
 > left unmaintained for much longer if it should be potentially marked
 > BROKEN and/or scheduled for removal?

Why on earth would we want to remove a working feature ?
Just because it isn't getting patched every release doesn't mean
it's rotting, Oprofile is actually one of the few kernel features which I
don't recall a single regression in since 2.6.0

BROKEN is for stuff that doesn't compile, or is fundamentally flawed
beyond repair at the current time (For example, needs infrastructure
work to happen before it can work correctly).

Oprofile fits neither of those categories.

		Dave
-- 
http://www.codemonkey.org.uk
