Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVA1NFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVA1NFl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 08:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVA1NFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 08:05:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64640 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261323AbVA1NFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 08:05:30 -0500
Date: Fri, 28 Jan 2005 08:01:17 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
In-Reply-To: <20050128053036.GO10843@holomorphy.com>
Message-ID: <Pine.LNX.4.61.0501280801070.24304@chimarrao.boston.redhat.com>
References: <20050127050927.GR10843@holomorphy.com> <16888.46184.52179.812873@alkaid.it.uu.se>
 <20050127125254.GZ10843@holomorphy.com> <20050127142500.A775@flint.arm.linux.org.uk>
 <20050127151211.GB10843@holomorphy.com> <Pine.LNX.4.61.0501271420070.13927@chimarrao.boston.redhat.com>
 <20050127204455.GM10843@holomorphy.com> <Pine.LNX.4.61.0501271557300.13927@chimarrao.boston.redhat.com>
 <20050127211319.GN10843@holomorphy.com> <Pine.LNX.4.61.0501271626460.13927@chimarrao.boston.redhat.com>
 <20050128053036.GO10843@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005, William Lee Irwin III wrote:

> You seem to be on about something else, e.g. only forbidding the vma
> allocator to return a vma starting at 0 when not specifically requested.
> In that case vma->vm_start < mm->brk and similar are all fine.

Yes.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
