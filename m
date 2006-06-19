Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWFSAPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWFSAPp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 20:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWFSAPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 20:15:44 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:43473 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932329AbWFSAPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 20:15:44 -0400
Date: Sun, 18 Jun 2006 17:15:11 -0700
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org, vojtech@suse.cz
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Message-Id: <20060618171511.e0e6de26.pj@sgi.com>
In-Reply-To: <200606140942.31150.ak@suse.de>
References: <200606140942.31150.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting - thanks Andi.

I had one of my colleagues at SGI lobby me hard for such a facility.
I'll see if I can get him on this thread to better explain what he
wanted it for.

Roughly, he was looking to support something resembling the kernel's
per-cpu data in userland library code for high performance scientific
number crunching, for things like statistics gathering and perhaps (not
sure of this) reduce locking costs.

I see "x86-64" in the Subject.  I don't see why this facility is
arch-specific.  Could it work on any arch, ia64 being the one of
interest to me?

I have some ignorance on your references to "CPUID(1)".  I don't recall
what it is.  The only command so named I find on my systems are a
Windows command from the year 1999.  I doubt that's it.  You wrote:

> As you can see CPUID(1) is always very slow

but but I don't see any stats above the comment mentioning CPUID(1),
so ... er eh ... no I don't see.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
