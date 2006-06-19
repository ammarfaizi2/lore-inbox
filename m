Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbWFSXve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbWFSXve (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 19:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWFSXve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 19:51:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64989 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932553AbWFSXvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 19:51:33 -0400
Date: Mon, 19 Jun 2006 19:51:28 -0400
From: Dave Jones <davej@redhat.com>
To: art@usfltd.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel-x64-smp-multiprocessor-speed & bogomips problem in /proc/cpuinfo
Message-ID: <20060619235128.GA22345@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, art@usfltd.com,
	linux-kernel@vger.kernel.org
References: <20060619183134.ow8kexp0jd6o0wck@69.222.0.225>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619183134.ow8kexp0jd6o0wck@69.222.0.225>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 06:31:34PM -0500, art@usfltd.com wrote:
 > kernel-x64-smp-multiprocessor-speed & bogomips problem in /proc/cpuinfo
 > 
 > $cat /proc/cpuinfo
 > processor       : 0
 > vendor_id       : AuthenticAMD
 > cpu family      : 15
 > model           : 43
 > model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4200+
 > stepping        : 1
 > cpu MHz         : 1000.000
 > cache size      : 512 KB
 > physical id     : 0
 > siblings        : 2
 > core id         : 0
 > cpu cores       : 2
 > fpu             : yes
 > fpu_exception   : yes
 > cpuid level     : 1
 > wp              : yes
 > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge  
 > mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext  
 > fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
 > bogomips        : 2005.64
 > TLB size        : 1024 4K pages
 > clflush size    : 64
 > cache_alignment : 64
 > address sizes   : 40 bits physical, 48 bits virtual
 > power management: ts fid vid ttp
                        ^^^^^^^

Your cpu can (and is) scaling its speed & voltage to save power.
Bogomips will scale accordingly.

		Dave

-- 
http://www.codemonkey.org.uk
