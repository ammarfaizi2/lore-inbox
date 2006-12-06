Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937579AbWLFTux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937579AbWLFTux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937581AbWLFTux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:50:53 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:40459 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937579AbWLFTuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:50:51 -0500
Date: Wed, 6 Dec 2006 12:50:50 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Christoph Lameter <clameter@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061206195050.GA3013@parisc-linux.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org> <20061206192647.GW3013@parisc-linux.org> <Pine.LNX.4.64.0612061128340.27363@schroedinger.engr.sgi.com> <20061206193641.GY3013@parisc-linux.org> <Pine.LNX.4.64.0612061147000.27534@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612061147000.27534@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 11:47:40AM -0800, Christoph Lameter wrote:
> Nope this is a UP implementation. There is no cpu B.

Follow the thread back.  I'm talking about parisc.  Machines exist (are
still being sold) with up to 128 cores.  I think the largest we've
confirmed work are 8 CPUs.
