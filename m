Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbVLNCnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbVLNCnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 21:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbVLNCnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 21:43:24 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:48389 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751366AbVLNCnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 21:43:24 -0500
Date: Wed, 14 Dec 2005 03:43:16 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Caroline GAUDREAU <caroline.gaudreau.1@ens.etsmtl.ca>
Cc: linux-kernel@vger.kernel.org, coywolf@gmail.com
Subject: Re: bugs?
Message-ID: <20051214024316.GG15993@alpha.home.local>
References: <439F79CE.6040609@ens.etsmtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439F79CE.6040609@ens.etsmtl.ca>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 08:47:58PM -0500, Caroline GAUDREAU wrote:
> my cpu is 1400MHz, but why there's cpu MHz         : 598.593
> 
> caro@olymphe:~$ cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 9
> model name      : Intel(R) Pentium(R) M processor 1400MHz
> stepping        : 5
> cpu MHz         : 598.593
> cache size      : 1024 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov 
> pat clflush dts acpi mmx fxsr sse sse2 tm pbe est tm2
> bogomips        : 1186.66

It's probably a notebook that you started unplugged from the mains power.
Mine is stupid enough to believe that I *want* to save power if I plug
the mains *after* powering it up ! And there's no way to force it to
switch from 600 to nominal freq afterwards ! So I have to connect it to
the mains first.

Regards,
Willy

