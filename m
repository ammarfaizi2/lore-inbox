Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283442AbRLHSBq>; Sat, 8 Dec 2001 13:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283496AbRLHSBm>; Sat, 8 Dec 2001 13:01:42 -0500
Received: from mout04.kundenserver.de ([195.20.224.89]:12064 "EHLO
	mout04.kundenserver.de") by vger.kernel.org with ESMTP
	id <S283442AbRLHSBY>; Sat, 8 Dec 2001 13:01:24 -0500
Date: Sat, 8 Dec 2001 18:38:32 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15 and GNU 3.0.2
Message-ID: <20011208173832.GA745@elfie.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <15362.34918.524256.760222@sinisa.nasamreza.org> <3C029E59.4040106@blue-labs.org> <15363.32056.147142.173419@sinisa.nasamreza.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15363.32056.147142.173419@sinisa.nasamreza.org>
User-Agent: Mutt/1.3.24-current-20011201i (Linux 2.4.17-pre6 i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 27 2001, Sinisa Milivojevic wrote:

> > Out of five computers I build kernels for at home here, one of them has 
> > an AMD K6II processor in it and that is the only one that I need to use 
> > gcc 2.95.3 with.  The rest I use 3.0.x and they are quite stable.

I have also two machines using AMD's K6

 elfie:~ # cat /proc/cpuinfo
 processor       : 0
 vendor_id       : AuthenticAMD
 cpu family      : 5
 model           : 9
 model name      : AMD-K6(tm) 3D+ Processor
 stepping        : 1
 cpu MHz         : 400.914
 cache size      : 256 KB
 fdiv_bug        : no
 hlt_bug         : no
 f00f_bug        : no
 coma_bug        : no
 fpu             : yes
 fpu_exception   : yes
 cpuid level     : 1
 wp              : yes
 flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
 bogomips        : 799.53

On one of them I compiled the kernel with

 elfie:~ # gcc -v
 Reading specs from /usr/local/gcc3/lib/gcc-lib/i586-pc-linux-gnu/3.1/specs
 Configured with: /Src/gcc-20011203/configure --prefix=/usr/local/gcc3
 Thread model: single
 gcc version 3.1 20011203 (experimental)

and there were no problems yet (5 days up).

-- 
# Heinz Diehl, 68259 Mannheim, Germany
