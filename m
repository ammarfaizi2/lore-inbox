Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbTETTgQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 15:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263900AbTETTgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 15:36:16 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:5235 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263845AbTETTgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 15:36:15 -0400
Date: Tue, 20 May 2003 12:51:40 -0700
From: Andrew Morton <akpm@digeo.com>
To: Cliff White <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: re-aim - 2.5.69, -mm6
Message-Id: <20030520125140.16f5cb46.akpm@digeo.com>
In-Reply-To: <200305201743.h4KHhMC25023@es175.pdx.osdl.net>
References: <200305201743.h4KHhMC25023@es175.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2003 19:49:11.0153 (UTC) FILETIME=[E2306E10:01C31F08]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White <cliffw@osdl.org> wrote:
>
>  This is the result of running the Reaim test against the 
>  2.5.69 and 2.5.69-mm6 kernels. The -mm kernels are a bit
>  slower, and i'm wondering if i'm missing a tuning knob somewhere..
>  advice appreciated.

I can look into the slowdown.  Could you please tell me exactly how you are
invoking the benchmark?  Show me what commands you're using, so I can do
exactly the same thing.

>  Attempting a second pass of -mm7 caused the hang reported earlier. 

I have a bad feeling I won't be able to reproduce this.  If you could
capture the output from a sysrq-T (or "echo t > /proc/sysrq-trigger") then
that would help a lot.

It could be a hole in the new dynamic request allocation code, or a driver
problem.  Or something else.
