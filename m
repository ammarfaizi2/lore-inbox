Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285227AbRL0Cbj>; Wed, 26 Dec 2001 21:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285273AbRL0Cb2>; Wed, 26 Dec 2001 21:31:28 -0500
Received: from wantadilla.lemis.com ([192.109.197.80]:34053 "HELO
	wantadilla.lemis.com") by vger.kernel.org with SMTP
	id <S285227AbRL0CbQ>; Wed, 26 Dec 2001 21:31:16 -0500
Date: Wed, 26 Dec 2001 11:39:42 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New per-cpu patch v2.5.1
Message-Id: <20011226113942.22bff120.rusty@rustcorp.com.au>
In-Reply-To: <1008829509.1213.8.camel@phantasy>
In-Reply-To: <E16GwUZ-0004xr-00@wagner.rustcorp.com.au>
	<1008829509.1213.8.camel@phantasy>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Dec 2001 01:24:45 -0500
Robert Love <rml@tech9.net> wrote:

> On Thu, 2001-12-20 at 01:15, Rusty Russell wrote:
> > After some discussion, this may be a more sane (untested) per-cpu area
> > patch.  It dynamically allocated the sections (and discards the
> > original), which would allow (future) NUMA people to make sure their
> > CPU area is allocated near them.
> > 
> > Comments welcome,
> 
> Would the next step be to find the various per-CPU data in the kernel
> and convert it to your new form?  I.e., is this a general purpose
> interface for per-CPU data structures, or am I missing something

Yep.  One step at a time...

Cheers,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
