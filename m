Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937116AbWLFTIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937116AbWLFTIh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760677AbWLFTIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:08:37 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:59494 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760669AbWLFTIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:08:36 -0500
Date: Wed, 6 Dec 2006 19:08:28 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061206190828.GE4587@ftp.linux.org.uk>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 11:05:22AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 6 Dec 2006, Christoph Lameter wrote:
> >
> > I'd really appreciate a cmpxchg that is generically available for 
> > all arches. It will allow lockless implementation for various performance 
> > criticial portions of the kernel.
> 
> I suspect ARM may have been the last one without one, no?

No.  sparc32 doesn't have one, for instance.
