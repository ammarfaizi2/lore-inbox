Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbWD1L1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWD1L1k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 07:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbWD1L1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 07:27:40 -0400
Received: from javad.com ([216.122.176.236]:19474 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S965022AbWD1L1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 07:27:40 -0400
From: Sergei Organov <osv@javad.com>
To: Avi Kivity <avi@argo.co.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
	<d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com>
	<444E61FD.7070408@argo.co.il> <200604271810.07575.vda@ilport.com.ua>
	<20060427201531.GH13027@w.ods.org>
	<750c918d0604271408y2afef6fflf380e4d0a6c1cec6@mail.gmail.com>
	<4451E185.9030107@argo.co.il> <4451E87D.1000102@argo.co.il>
Date: Fri, 28 Apr 2006 15:27:29 +0400
In-Reply-To: <4451E87D.1000102@argo.co.il> (Avi Kivity's message of "Fri, 28
	Apr 2006 13:03:41 +0300")
Message-ID: <87irou0wke.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity <avi@argo.co.il> writes:

> Avi Kivity wrote:
>>
>> Kernels of other operating systems (Windows, AIX (?)) allow C++. And
>> don't start about Windows crashing whenever you sneeze at it - it's
>> so 1998.
>>
>
> Oh, and it looks like some guy even wrote a kernel [1] in C++! Lucky
> we don't have people like that working on Linux.
>
> [1] http://www.zipworld.com.au/~akpm/#rtos

FYI, the core of another, more widely used open-source RTOS, eCos [2],
is written in C++ as well though it supports C for drivers development
and its public interface is C wrapper around the C++ core.

On the other hand, I think I do understand Linux hackers` worries about
C++ leaking into the Linux kernel. For many supporting C++, even in the
modules only, is only slightly different from supporting binary drivers,
I guess. That could be in fact very serious problem, I'm afraid.

[2] <http://ecos.sourceware.org/>

-- 
Sergei.
