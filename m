Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278326AbRJMQe3>; Sat, 13 Oct 2001 12:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278347AbRJMQeI>; Sat, 13 Oct 2001 12:34:08 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:57354
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S278348AbRJMQdz>; Sat, 13 Oct 2001 12:33:55 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200110131614.f9DGEPA20311@www.hockin.org>
Subject: Re: cpus_allowed
To: rml@tech9.net (Robert Love)
Date: Sat, 13 Oct 2001 09:14:25 -0700 (PDT)
Cc: fokkensr@linux06.vertis.nl (Rolf Fokkens), linux-kernel@vger.kernel.org
In-Reply-To: <1002990137.868.59.camel@phantasy> from "Robert Love" at Oct 13, 2001 12:22:15 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Most of the CPU affinity patches you see were written before
> cpus_allowed.  They go through all sorts of trouble to do what the OS
> now does on its own.  If you want to change CPU affinity then you just
> need a patch that adds a syscall or proc interface for setting the
> cpus_allowed mask.

I'm still porting pset to 2.4.  It is more robust than cpus_allowed and
does more.  My plan is to do away with cpus_allowed altogether, and just
provide a compat with pset, but if enough stuff uses cpus_allowed, perhaps
I'll have to leave it..

http://www.hockin.org/~thockin/pset

2.4.x patch not up yet
