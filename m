Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWHVLnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWHVLnL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 07:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWHVLnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 07:43:10 -0400
Received: from 207.47.60.150.static.nextweb.net ([207.47.60.150]:51076 "EHLO
	webmail.xensource.com") by vger.kernel.org with ESMTP
	id S932179AbWHVLnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 07:43:09 -0400
Subject: Re: [PATCH 1 of 1] x86_43: Put .note.* sections into a PT_NOTE
	segment in vmlinux
From: Ian Campbell <Ian.Campbell@XenSource.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@XenSource.com>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <ian.pratt@XenSource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization <virtualization@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
In-Reply-To: <20060822133306.79fac714.ak@suse.de>
References: <2bf2abf6e97048bbef24.1154462451@ezr>
	 <1156245258.5091.17.camel@localhost.localdomain>
	 <20060822133306.79fac714.ak@suse.de>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 12:43:09 +0100
Message-Id: <1156246989.5091.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Aug 2006 11:44:55.0458 (UTC) FILETIME=[6337B820:01C6C5E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 13:33 +0200, Andi Kleen wrote:
> On Tue, 22 Aug 2006 12:14:18 +0100
> Ian Campbell <Ian.Campbell@XenSource.com> wrote:
> 
> > On Tue, 2006-08-01 at 13:00 -0700, Jeremy Fitzhardinge wrote:
> > > This patch will pack any .note.* section into a PT_NOTE segment in the
> > > output file.
> > [...]
> > > This only changes i386 for now, but I presume the corresponding
> > > changes for other architectures will be as simple.
> > 
> > Here is the patch for x86_64.
> 
> Ok, but can you please resubmit with complete changelog/rationale?

Will do.

I've just noticed a bunch of sections (.vsyscall_*, .xtime and others)
which aren't getting put into segments for some reason. I'll figure that
out first...

Ian.


