Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbTGCTSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 15:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbTGCTSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 15:18:30 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:19093 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264085AbTGCTS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 15:18:28 -0400
Date: Thu, 3 Jul 2003 15:32:47 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
In-Reply-To: <20030703192750.GM23578@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0307031531460.2785-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jul 2003, Andrea Arcangeli wrote:

> that's the very old exploit that touches 1 page per pmd.

> if you can't use a sane design it's not a kernel issue.

Agreed, the kernel shouldn't have to go out of its way to
give these applications good performance.  On the other
hand, I think the kernel should be able to _survive_
applications like this, reclaiming page tables when needed.

-- 
Great minds drink alike.

