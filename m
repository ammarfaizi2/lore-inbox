Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273302AbTHKS5q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273272AbTHKS43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:56:29 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:56783 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S272988AbTHKSyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:54:40 -0400
Date: Mon, 11 Aug 2003 11:57:25 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm1
Message-ID: <864380000.1060628245@flay>
In-Reply-To: <20030811180552.GG32488@holomorphy.com>
References: <20030809203943.3b925a0e.akpm@osdl.org> <94490000.1060612530@[10.10.2.4]> <20030811180552.GG32488@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Aug 11, 2003 at 07:35:31AM -0700, Martin J. Bligh wrote:
>> Degredation on kernbench is still there:
>> Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
>>                               Elapsed      System        User         CPU
>>               2.6.0-test3       45.97      115.83      571.93     1494.50
>>           2.6.0-test3-mm1       46.43      122.78      571.87     1496.00
>> Quite a bit of extra sys time. I thought the suspected part of the sched
>> changes got backed out, but maybe I'm just not following it ...
> 
> Is this with or without the unit conversion fix for the load balancer?
> 
> It will be load balancing extra-aggressively without the fix.

This is virgin ... can you point me back to the fix you mention?
I missed that one.

M.

