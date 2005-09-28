Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbVI1RgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbVI1RgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 13:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVI1RgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 13:36:14 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:25825 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751421AbVI1RgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 13:36:13 -0400
Date: Wed, 28 Sep 2005 10:34:20 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Simon White <s_a_white@email.com>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Best Kernel Timers?
In-Reply-To: <20050928100858.824F5101D9@ws1-3.us4.outblaze.com>
Message-ID: <Pine.LNX.4.62.0509281033420.14338@schroedinger.engr.sgi.com>
References: <20050928100858.824F5101D9@ws1-3.us4.outblaze.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Simon White wrote:

> I posted a similiar question there but received no response.  From
> what I can tell it is a frame work for providing hardware specific
> timer sources to the kernel and also exporting posix userspace
> system calls from the kernel.  It may do more in kernel but haven't
> found exactly what it does, relevent docs?  Also is this in mainline
> (or soon to be) or just patches against it?

This is in mainline since 2.6.10. You can define additional clocks.

CLOCK_MYCLOCK

and then register a new posix clock.

