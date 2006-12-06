Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937605AbWLFUML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937605AbWLFUML (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 15:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937603AbWLFUML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 15:12:11 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:55936 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937602AbWLFUMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 15:12:08 -0500
Date: Wed, 6 Dec 2006 12:11:01 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Matthew Wilcox <matthew@wil.cx>
cc: Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <20061206195050.GA3013@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0612061209240.27847@schroedinger.engr.sgi.com>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org> <20061206192647.GW3013@parisc-linux.org>
 <Pine.LNX.4.64.0612061128340.27363@schroedinger.engr.sgi.com>
 <20061206193641.GY3013@parisc-linux.org> <Pine.LNX.4.64.0612061147000.27534@schroedinger.engr.sgi.com>
 <20061206195050.GA3013@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006, Matthew Wilcox wrote:

> On Wed, Dec 06, 2006 at 11:47:40AM -0800, Christoph Lameter wrote:
> > Nope this is a UP implementation. There is no cpu B.
> 
> Follow the thread back.  I'm talking about parisc.  Machines exist (are
> still being sold) with up to 128 cores.  I think the largest we've
> confirmed work are 8 CPUs.

And you only have an atomic get and clear atomic op? Amazing. Is this 
really still in production?


