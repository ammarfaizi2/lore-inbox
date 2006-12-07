Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937939AbWLGBob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937939AbWLGBob (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 20:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937938AbWLGBob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 20:44:31 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:53744 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937936AbWLGBoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 20:44:30 -0500
Date: Wed, 6 Dec 2006 18:44:28 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Christoph Lameter <clameter@sgi.com>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061207014428.GH3013@parisc-linux.org>
References: <20061206195820.GA15281@flint.arm.linux.org.uk> <20061206213626.GE3013@parisc-linux.org> <Pine.LNX.4.64.0612061345160.28672@schroedinger.engr.sgi.com> <20061206220532.GF3013@parisc-linux.org> <Pine.LNX.4.64.0612070130240.1868@scrub.home> <Pine.LNX.4.64.0612061650240.3542@woody.osdl.org> <Pine.LNX.4.64.0612070203520.1867@scrub.home> <Pine.LNX.4.64.0612061717030.3542@woody.osdl.org> <Pine.LNX.4.64.0612070219540.1867@scrub.home> <Pine.LNX.4.64.0612061735150.3542@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612061735150.3542@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 05:36:29PM -0800, Linus Torvalds wrote:
> Or are you saying that gcc aligns normal 32-bit entities at 
> 16-bit alignment? Neither of those sound very likely.

alignof(u32) is 2 on m68k.  Crazy, huh?
