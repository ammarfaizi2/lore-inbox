Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWCHAXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWCHAXy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWCHAXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:23:54 -0500
Received: from drugphish.ch ([69.55.226.176]:10704 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S964828AbWCHAXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:23:53 -0500
Message-ID: <440E2428.5030303@drugphish.ch>
Date: Wed, 08 Mar 2006 01:24:08 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: David Howells <dhowells@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Document Linux's memory barriers
References: <200603071819_MC3-1-BA15-3119@compuserve.com>
In-Reply-To: <200603071819_MC3-1-BA15-3119@compuserve.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>The attached patch documents the Linux kernel's memory barriers.
> 
> References:
> 
> AMD64 Architecture Programmer's Manual Volume 2: System Programming
>         Chapter 7.1: Memory-Access Ordering
>         Chapter 7.4: Buffering and Combining Memory Writes
> 
> IA-32 Intel Architecture Software Developer’s Manual, Volume 3:
> System Programming Guide
>         Chapter 7.1: Locked Atomic Operations
>         Chapter 7.2: Memory Ordering
>         Chapter 7.4: Serializing Instructions

Do you guys reckon it might be worthwhile adding Sparc's sequential 
consistency, TSO, RMO and PSO models, although I think only RMO is used 
in the Linux kernel? References can be found for example in:

   Solaris Internals, Core Kernel Architecture, p63-68:
           Chapter 3.3: Hardware Considerations for Locks and
                        Synchronization

   Unix Systems for Modern Architectures, Symmetric Multiprocessing
   and Caching for Kernel Programmers:
           Chapter 13 : Other Memory Models

Or is DaveM the only one fiddling with Sparc memory barriers implementation?

Regards,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
