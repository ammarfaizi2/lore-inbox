Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVBFR6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVBFR6y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVBFR6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:58:54 -0500
Received: from ns.suse.de ([195.135.220.2]:57827 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261262AbVBFR6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:58:32 -0500
Date: Sun, 6 Feb 2005 18:58:28 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       akpm@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206175828.GB18245@wotan.suse.de>
References: <20050206113635.GA30109@wotan.suse.de> <20050206114758.GA8437@infradead.org> <20050206123355.GB30109@wotan.suse.de> <Pine.LNX.4.58.0502060904140.2165@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502060904140.2165@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 09:05:05AM -0800, Linus Torvalds wrote:
> 
> 
> On Sun, 6 Feb 2005, Andi Kleen wrote:
> > 
> > There are probably more.
> 
> So? Do you expect to never fix them, or what?

Someone will fix them, but it's not the job of the 32bit emulation
of x86-64 to break compatibility. It's whole point is to be compatible,
not expose bugs.

If someone else wants to break existing programs they can 
do that if they think they have the capability to deal
with (rightfully) annoyed user space people. 

But not with x86-64 compat mode leading the front here.

-Andi
