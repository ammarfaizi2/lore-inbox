Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266851AbUGLOdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266851AbUGLOdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 10:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266852AbUGLOdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 10:33:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:7863 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266851AbUGLOdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 10:33:33 -0400
Date: Mon, 12 Jul 2004 07:33:24 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Con Kolivas <kernel@kolivas.org>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Instrumenting high latency
Message-ID: <78220000.1089642803@[10.10.2.4]>
In-Reply-To: <40F29FCF.3070302@kolivas.org>
References: <cone.1089613755.742689.28499.502@pc.kolivas.org> <75270000.1089642258@[10.10.2.4]> <40F29FCF.3070302@kolivas.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Con Kolivas <kernel@kolivas.org> wrote (on Tuesday, July 13, 2004 00:27:27 +1000):

> Martin J. Bligh wrote:
>>> Because of the recent discussion about latency in the kernel I asked 
>>> William Lee Irwin III to help create some instrumentation to determine 
>>> where in the kernel there were still sustained periods of non-preemptible 
>>> code. He hacked together this simple patch which times periods according 
>>> to the preempt count. Hopefully we can use this patch in the advice of 
>>> Linus to avoid the "mental masturbation" at guessing where latency is 
>>> and track down real problem areas.
>> 
>> 
>> Is this much different from Rick's schedstat's work, which was itself based
>> on some earlier patches by Bill? I'd hate to end up with two sets of patches,
>> and schedstats seemed pretty comprehensive to me. He's on vacation, but his
>> stuff is here, if you want to take a look:
>> 
>> http://eaglet.rain.com/rick/linux/schedstats/
> 
> No I remember his work and this is tackling it via a different area if I 
> recall correctly. He was looking at scheduler latencies as opposed to 
> non-preemptible kernel code.

Fair enough ... is it worth adding it to the same harness though? He had lots
of nice analysis tools set up to do comparisons and graphing, etc.

M.

