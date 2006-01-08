Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbWAHAj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbWAHAj3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 19:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbWAHAj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 19:39:29 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:14271 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161107AbWAHAj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 19:39:27 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client    on interactive response
Date: Sun, 8 Jan 2006 11:38:50 +1100
User-Agent: KMail/1.9
Cc: Mike Galbraith <efault@gmx.de>, Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5.2.1.1.2.20060106074738.00bbaeb8@pop.gmx.net> <200601072030.59445.kernel@kolivas.org> <43C04F47.7000002@bigpond.net.au>
In-Reply-To: <43C04F47.7000002@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601081138.51198.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 January 2006 10:31, Peter Williams wrote:
> In any case and in the meantime, perhaps the solution is to use
> TASK_NONINTERACTIVE where needed but treat
> TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE sleep the same as
> TASK_UNINTERRUPTIBLE sleep instead of ignoring it?

That's how I would tackle it.

Con
