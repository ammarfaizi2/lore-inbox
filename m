Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266805AbUJAXc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266805AbUJAXc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 19:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266837AbUJAXc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 19:32:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58504 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266805AbUJAXc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 19:32:56 -0400
Date: Fri, 1 Oct 2004 16:30:30 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Roland McGrath <roland@redhat.com>
cc: Ulrich Drepper <drepper@redhat.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, george@mvista.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: [RFC] Posix compliant behavior of CLOCK_PROCESS/THREAD_CPUTIME_ID
In-Reply-To: <200410012157.i91LvlPj021414@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0410011629500.19747@schroedinger.engr.sgi.com>
References: <200410012157.i91LvlPj021414@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2004, Roland McGrath wrote:

> I have been working on an alternate patch that implements more complete CPU
> clock functionality.  This includes access to other threads' and process'
> times, potentially finer-grained information (based on sched_clock), and
> timers.  I will post this code when it's ready, hopefully soon.

Umm... How would you do that in a posix compliant way? This information is
already available via /proc

