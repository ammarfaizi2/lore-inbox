Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263752AbUGRLBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbUGRLBa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 07:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUGRLB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 07:01:29 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:3218 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S263752AbUGRLB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 07:01:27 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: "Harald Dunkel" <harald.dunkel@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: amd64, 2.6.7: several problems
Date: Sun, 18 Jul 2004 13:10:51 +0200
User-Agent: KMail/1.5
References: <40FA1A69.4090902@t-online.de>
In-Reply-To: <40FA1A69.4090902@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407181310.51267.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 of July 2004 08:36, Harald Dunkel wrote:
> Hi folks,
>
> I've got some questions about amd64.
>
> /proc/cpuinfo returns
>
> 	processor       : 0
> 	vendor_id       : AuthenticAMD
> 	cpu family      : 15
> 	model           : 12
> 	model name      : AMD Athlon(tm) 64 Processor 3200+
> 	stepping        : 0
> 	cpu MHz         : 2194.366
> 	cache size      : 512 KB
> 	fpu             : yes
> 	fpu_exception   : yes
> 	cpuid level     : 1
> 	wp              : yes
> 	flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext
> 3dnow bogomips        : 4341.76
> 	TLB size        : 1088 4K pages
> 	clflush size    : 64
> 	cache_alignment : 64
> 	address sizes   : 40 bits physical, 48 bits virtual
> 	power management: ts fid vid ttp
>
> Please check the cache size. It _should_ be 1024 kB, at least that was
> written on the bill I've got. Is this correct?

Well, not.  There are two "versions" of Athlon64 3200+, one of which has 1024 
KB of cache and is clocked at 2.0 GHz, and the second has 512 KB of cache and 
is clocked at 2.2 GHz.  Yours is the second one, apparently.  More info at:

http://www.amdboard.com/athlon_64_3200.html

Yours,
rjw

-- 
Rafael J. Wysocki
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
