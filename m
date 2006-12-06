Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759698AbWLFCh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759698AbWLFCh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 21:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759706AbWLFCh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 21:37:29 -0500
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:35572 "EHLO
	liaag2ag.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759696AbWLFCh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 21:37:28 -0500
Date: Tue, 5 Dec 2006 21:31:42 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Kasper Sandberg <lkml@metanurb.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>, ak@muc.de, vojtech@suse.cz
Message-ID: <200612052134_MC3-1-D40B-A5DB@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <26586.1165356671@redhat.com>

On Tue, 05 Dec 2006 22:11:11 +0000, David Howells wrote:

> > I only have 32-bit userspace.  When I run your program against
> > a directory on a JFS filesystem (msdos ioctls not supported)
> > I get this on vanilla 2.6.19:
> 
> Can I just check?  You're using an x86_64 CPU in 64-bit mode with a 64-bit
> kernel, but with a completely 32-bit userspace?

It's FC5 i386 so there's no way any 64-bit userspace code is in there.
(I have a cross-compiler only for building kernels.)  Having a pure
32-bit userspace lets me switch between i386 and x86_64 kernels
without having to maintain two separate Linux installs.

> A question for you: Why is userspace assuming that it'll get ENOTTY rather
> than EINVAL?

I'm not sure it is, but that's what it used to get.

Kasper, what problems (other that the annoying message) are you having?

-- 
Chuck
"Even supernovas have their duller moments."

