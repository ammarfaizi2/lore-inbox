Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVCVPC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVCVPC5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 10:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVCVPC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 10:02:57 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:18864 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261327AbVCVPCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 10:02:53 -0500
Date: Tue, 22 Mar 2005 10:02:49 -0500
From: Tom Vier <tmv@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: not for amd Re: Distinguish real vs. virtual CPUs?
Message-ID: <20050322150249.GA10709@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <20050321202726.A7630@morpheus> <20050322015603.GB19541@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322015603.GB19541@redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 08:56:03PM -0500, Dave Jones wrote:
> Compare the 'physical id' fields of /proc/cpuinfo, and count
> how many unique values you get.

It doesn't work for opteron, at least. These are in two sockets, but the
phys id is the same.

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 244
stepping        : 8
cpu MHz         : 1792.493
cache size      : 1024 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 pni syscall nx mmxext lm 3dnowext
3dnow
bogomips        : 3514.36

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 244
stepping        : 10
cpu MHz         : 1792.493
cache size      : 1024 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 pni syscall nx mmxext lm 3dnowext
3dnow
bogomips        : 3571.71

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
