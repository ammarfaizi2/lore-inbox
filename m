Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288544AbSAHXD2>; Tue, 8 Jan 2002 18:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288543AbSAHXDT>; Tue, 8 Jan 2002 18:03:19 -0500
Received: from zero.tech9.net ([209.61.188.187]:62216 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288541AbSAHXDM>;
	Tue, 8 Jan 2002 18:03:12 -0500
Subject: Re: [PATCH] preempt abstraction
From: Robert Love <rml@tech9.net>
To: David Howells <dhowells@redhat.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Roger Larsson <roger.larsson@norran.net>,
        Andrew Morton <akpm@zip.com.au>, Christoph Hellwig <hch@caldera.de>,
        torvalds@transmeta.com, arjanv@redhat.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <12550.1010530018@warthog.cambridge.redhat.com>
In-Reply-To: <12550.1010530018@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 08 Jan 2002 18:05:13 -0500
Message-Id: <1010531114.3225.172.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-08 at 17:46, David Howells wrote:

> ftp://infradead.org/pub/people/dwh/yield-252p10.diff.bz2
> 
> There's now a version of the patch with preempt/need_preempt changed to
> yield/need_yield, and with the unlikely() claused moved into need_yield(),
> should that be more to your preference.

Still not the name I would pick, but better :)

Oh, and need_yield is still marked unlikely in sched.c

Good patch,

	Robert Love

