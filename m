Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317447AbSFRP0O>; Tue, 18 Jun 2002 11:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317448AbSFRP0N>; Tue, 18 Jun 2002 11:26:13 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:4045 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317447AbSFRP0M>; Tue, 18 Jun 2002 11:26:12 -0400
Date: Tue, 18 Jun 2002 16:58:24 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Jonathan Abbey <jonabbey@arlut.utexas.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops in 2.4.18-3 kswapd?
In-Reply-To: <20020618100046.A23353@arlut.utexas.edu>
Message-ID: <Pine.LNX.4.44.0206181655530.1263-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Jonathan Abbey wrote:

> Got the following on a RedHat 7.3 system with, yes, the NVidia driver
> added.
> 
> Jun 18 04:03:38 greatland kernel: ------------[ cut here ]------------
> Jun 18 04:03:38 greatland kernel: kernel BUG at page_alloc.c:117!
> Jun 18 04:03:38 greatland kernel: invalid operand: 0000
> Jun 18 04:03:38 greatland kernel: sr_mod es1371 ac97_codec gameport soundcore agpgart NVdriver binfmt_misc autof
> Jun 18 04:03:38 greatland kernel: CPU:    0
> Jun 18 04:03:38 greatland kernel: EIP:    0010:[<c0132dc7>]    Tainted: P 
> Jun 18 04:03:38 greatland kernel: EFLAGS: 00010282
> Jun 18 04:03:38 greatland kernel: 
> Jun 18 04:03:38 greatland kernel: EIP is at __free_pages_ok [kernel] 0x57 (2.4.18-3)
> Jun 18 04:03:38 greatland kernel: eax: 00000020   ebx: c1128170   ecx: 00000001   edx: 0001f4fb
> Jun 18 04:03:38 greatland kernel: esi: 00000000   edi: c02ccf5c   ebp: 00000000   esp: c1715f58
> Jun 18 04:03:38 greatland kernel: ds: 0018   es: 0018   ss: 0018

*sigh* this could become an FAQ, new nVidia driver seems to have worked 
its magic on that kernel (__free_pages_ok). Try running the 2314 drivers 
or perhaps the 2960.

Cheers,
	Zwane Mwaikambo
-- 
http://function.linuxpower.ca
		

