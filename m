Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265113AbUD3Ia0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbUD3Ia0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 04:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265116AbUD3IaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 04:30:25 -0400
Received: from holomorphy.com ([207.189.100.168]:16000 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265113AbUD3IaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 04:30:22 -0400
Date: Fri, 30 Apr 2004 01:30:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NUMA API
Message-ID: <20040430083017.GB1298@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ulrich Drepper <drepper@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <409201BE.9000909@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409201BE.9000909@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 12:35:26AM -0700, Ulrich Drepper wrote:
> In the last weeks I have been working on designing a new API for a NUMA
> support library.  I am aware of the code in libnuma by ak but this code
> has many shortcomings:
> ~ inadequate topology discovery
> ~ fixed cpu set size
> ~ no clear separation of memory nodes
> ~ no inclusion of SMT/multicore in the cpu hierarchy
> ~ awkward (at best) memory allocation interface
> ~ etc etc
> and last but not least
> ~ a completely unacceptable library interface (e.g., global variables as
> part of the API, WTF?)

Regardless of issues addressed, Andi's been working with everyone for
something on the order of 12+ months and this is out of the blue. I very
very strongly suggest that you take up each of these issues with him so
that they can be addressed as individual incremental improvements to the
API everyone's been working with for all that time as opposed to screwing
the world (esp. now that commodity NUMA boxen are becoming more prevalent)
with transparent and deliberate distro-competition motivated API skew.

-- wli
