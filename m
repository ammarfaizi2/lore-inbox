Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263815AbUE1T0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUE1T0E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 15:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUE1T0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 15:26:04 -0400
Received: from smtp.wp.pl ([212.77.101.160]:60087 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S263815AbUE1T0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 15:26:00 -0400
Date: Fri, 28 May 2004 21:25:58 +0200
From: "=?ISO-8859-2?Q?Rafa=B3?= 'rmrmg' Roszak" <rmrmg@wp.pl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1-mm1
Message-Id: <20040528212558.4c96990d.rmrmg@wp.pl>
In-Reply-To: <20040527015259.3525cbbc.akpm@osdl.org>
References: <20040527015259.3525cbbc.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A. [wersja 2.0c]
X-WP-AntySpam-Rezultat: NIE-SPAM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops: 0000 [#1]
Modules linked in: w83627hf i2c_sensor i2c_isa tvaudio tda9875 bttv
video_buf i2c_algo_bit v4l2_common btcx_risc videodev tuner i2c_core
emu10k1 i810_audio ac97_codec nvidia_agp agpgart hisax isdn rtc CPU:   
0 EIP:    0060:[<c01c55f2>]    Not tainted VLI
EFLAGS: 00010246   (2.6.7-rc1-mm1) 
EIP is at driver_attach+0x32/0x90
eax: 00000000   ebx: 00000000   ecx: ffffffed   edx: 00000000
esi: d0f31280   edi: d0ef55c8   ebp: 00000000   esp: cf765f40
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 91, threadinfo=cf764000 task=cf777160)
Stack: d0f31280 c01a30d2 00000000 d0f31298 d0ef556c d0ef5520 d0f31280
c01c588f        d0f31298 d0f31244 c02b4ed8 d0f31240 d0ef53f0 cf764000
c01c5c88 00000015        00000014 00000016 d0f295c8 d0ef1490 c02b4ed8
d0f31d80 c02b4ec0 cf764000 Call Trace:
 [<c01a30d2>] kobject_register+0x22/0x60
 [<c01c588f>] bus_add_driver+0x8f/0xc0
 [<c01c5c88>] driver_register+0x28/0x30
 [<d0ef1490>] i2c_add_driver+0x50/0xc0 [i2c_core]
 [<d0e95025>] sensors_w83627hf_init+0x25/0x2d [w83627hf]
 [<c0125744>] sys_init_module+0xe4/0x1c0
 [<c0137d00>] sys_munmap+0x40/0x70
 [<c010397f>] syscall_call+0x7/0xb

Code: 10 8b 40 04 8b 98 e8 00 00 00 85 db 74 4f 8b 98 a8 00 00 00 8b 13
0f 18 02 90 8d b8 a8 00 00 00 eb 0f 8d b4 26 00 00 00 00 89 d3 <8b> 12
0f 18 02 90 39 df 74 28 8d 43 f8 8b 48 70 85 c9 75 ea 89 

-- 
. JID: rmrmg(at)jabberpl(dot)org |   RMRMG   .
.           gg: #2311504         | signature .
.   mail: rmrmg(at)wp(dot)pl     |  version  .
.  registered Linux user 261525  |   0.0.3   .
