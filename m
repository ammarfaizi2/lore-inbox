Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032297AbWLGPGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032297AbWLGPGQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032299AbWLGPGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:06:16 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2873 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032297AbWLGPGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:06:15 -0500
Date: Thu, 7 Dec 2006 15:06:06 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-arm-kernel@lists.arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061207150606.GC1255@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Christoph Lameter <clameter@sgi.com>,
	David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-arch@vger.kernel.org
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org>
User-Agent: Mutt/1.4.2.1i
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
> 
> That said, cmpxchg won't necessarily be "high-performance" unless the hw 
> supports it naturally in hardware, so..
> 
> Russell, are you ok with the code DavidH posted (the "try 2" one)? I'd 
> like to get an ack from the ARM maintainer before applying it, but it 
> looked ok.

Things seem to have moved on since this request.  Do I need to do
anything?  I dunno.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
