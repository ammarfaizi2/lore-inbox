Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268391AbTBYUrS>; Tue, 25 Feb 2003 15:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268400AbTBYUrS>; Tue, 25 Feb 2003 15:47:18 -0500
Received: from ms-smtp-01.tampabay.rr.com ([65.32.1.43]:11224 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S268391AbTBYUrR>; Tue, 25 Feb 2003 15:47:17 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: <jlnance@unity.ncsu.edu>, <linux-kernel@vger.kernel.org>
Subject: RE: Minutes from Feb 21 LSE Call
Date: Tue, 25 Feb 2003 15:59:10 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJAEPFEPAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030225201832.GA9442@ncsu.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@unity.ncsu.edu wrote:
> I think the difference between SMP and HT is likely to decrease rather
> than increase in the future.  Even now people want to put multiple CPUs
> on the same piece of silicon.  Once you do that it only makes sense to
> start sharning things between them.  If you had a system with 2 CPUs
> which shared a common L1 cache is that going to be a HT or an SMP system?
> Or you could go further and have 2 CPUs which share an FPU.  There are
> all sorts of combinations you could come up with.  I think designers
> will experiment and find the one that gives the most throughput for
> the least money.

IBM's forthcoming Power5 will have two cores, each with SMT (the generic
term for HyperThreading); it will present itself to the OS as four
processors. Those four processors, however, are not equal; SMT is certainly
valuable, but it can only be as effective as mutliple cores if it in effect
*becomes* multiple cores (and, as such, turns into SMP).

I'm writing a chapter on memory architectures in my parallel programming
book; it's giving me a bit of a headache, as the issues you raise are both
important and complex. We have multiple levels of caches, NUMA
architectures, clusters, SMP, HT... the list just goes on and on, infinite
in diversity and combinations. Vendors will continue to experiment; I doubt
very much that any one architecture will take center stage.

I hope Linux handles the brain-sprain better than I am at the moment! ;)

..Scott

Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)

