Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVKJUqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVKJUqN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVKJUqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:46:13 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:35734 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932099AbVKJUqL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:46:11 -0500
Date: Fri, 11 Nov 2005 02:25:26 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: IO-APIC problem with 2.6.14-rt9
Message-ID: <20051110205526.GC16301@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20051110200226.GA18780@in.ibm.com> <20051110200205.GA4696@elte.hu> <20051110203000.GB16301@in.ibm.com> <1131654575.27168.685.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131654575.27168.685.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 12:29:34PM -0800, john stultz wrote:
> 
> Hrm. Could you post the value for BogoMIPS that you're getting now?

Here it is

vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) MP CPU 2.50GHz
stepping        : 5
cpu MHz         : 2488.063
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 4975.15


I checked that this is the same even on a vanilla 2.6.14 as well

	-Dinakar

