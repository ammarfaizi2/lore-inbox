Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267376AbUJGKDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267376AbUJGKDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 06:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUJGKBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 06:01:51 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:6016 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S267376AbUJGJ72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:59:28 -0400
Date: Thu, 7 Oct 2004 11:59:20 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Nick Sanders <sandersn@btinternet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3
Message-ID: <20041007115920.1fa90e35@phoebee>
In-Reply-To: <200410071041.20723.sandersn@btinternet.com>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	<200410071041.20723.sandersn@btinternet.com>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__7_Oct_2004_11_59_20_+0200_X2v6k38sgw2OScON"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__7_Oct_2004_11_59_20_+0200_X2v6k38sgw2OScON
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 7 Oct 2004 10:41:20 +0100
Nick Sanders <sandersn@btinternet.com> bubbled:

> On Thursday 07 October 2004 09:51, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6
> >.9-rc3-mm3/
> >
> 
> I get the following oops when booting and it also stops kde
> (artswrapper) from starting with the same call trace. USB seems to be
> working which is good.
> 
> Thanks
> 
> Nick
> 
> Oct  7 10:20:25 gandalf kernel: Unable to handle kernel paging request
> at virtual address 0000f4cc
> Oct  7 10:20:25 gandalf kernel:  printing eip:
> Oct  7 10:20:25 gandalf kernel: c01176a6
> Oct  7 10:20:25 gandalf kernel: *pde = 00000000
> Oct  7 10:20:25 gandalf kernel: Oops: 0002 [#1]
> Oct  7 10:20:25 gandalf kernel: Modules linked in:
> Oct  7 10:20:25 gandalf kernel: CPU:    0
> Oct  7 10:20:25 gandalf kernel: EIP:    0060:[profile_hit+38/48]   
> Not tainted VLI
> Oct  7 10:20:25 gandalf kernel: EFLAGS: 00013086   (2.6.9-rc3-mm3)
> Oct  7 10:20:25 gandalf kernel: EIP is at profile_hit+0x26/0x30
> Oct  7 10:20:25 gandalf kernel: eax: 0000f4cc   ebx: dfa8f0a0   ecx:
> 00000000   edx: 00000000
> Oct  7 10:20:25 gandalf kernel: esi: ffffffea   edi: 00000002   ebp:
> dfbe9fbc   esp: dfbe9f8c
> Oct  7 10:20:25 gandalf kernel: ds: 007b   es: 007b   ss: 0068
> Oct  7 10:20:25 gandalf kernel: Process isapnp (pid: 981,
> threadinfo=dfbe8000 task=dfa8f0a0)
> Oct  7 10:20:25 gandalf kernel: Stack: c0114070 00000002 c0103f5b
> 00000004 c034ca20 00005401 bffffbe0 00003086
> Oct  7 10:20:25 gandalf kernel:        00000032 000003d5 00000000
> 00000000 dfbe8000 c0103f5b 000003d5 00000002
> Oct  7 10:20:25 gandalf kernel:        bffffd04 00000000 00000000
> bffffd08 0000009c 0000007b 0000007b 0000009c
> Oct  7 10:20:25 gandalf kernel: Call Trace:
> Oct  7 10:20:25 gandalf kernel:  [setscheduler+176/480] 
> setscheduler+0xb0/0x1e0
> Oct  7 10:20:25 gandalf kernel:  [syscall_call+7/11]
> syscall_call+0x7/0xb Oct  7 10:20:25 gandalf kernel: 
> [syscall_call+7/11] syscall_call+0x7/0xb Oct  7 10:20:25 gandalf
> kernel: Code: 24 83 c4 08 c3 8b 44 24 08 8b 0d ac 1c 35 c0 8b 15 a8 1c
> 35 c0 2d 28 02 10 c0 d3 e8 4a 39 c2 0f 46 c2 8b 15 a4 1c 35 c
> 0 8d 04 82 <ff> 00 c3 8d b4 26 00 00 00 00 b8 da ff ff ff c3 8d 76 00
> 8d bc
> 


I get the same oops :(

....
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
...
Unable to handle kernel paging request at virtual address 0000f0fc
 printing eip:
c011b8a7
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: stv0299 dvb_ttpci dvb_core firmware_class saa7146_vv video_buf saa7146 ttpci_eeprom i2c_sis96x sis_agp agpgart iptable_filter iptable_nat iptable_mangle ipt_state ip_conntrack ipt_REJECT ipt_LOG ip_tables
CPU:    0
EIP:    0060:[<c011b8a7>]    Tainted: P      VLI
EFLAGS: 00010086   (2.6.9-rc3-mm3)
EIP is at profile_hit+0x23/0x26
eax: 00000000   ebx: d8c10a00   ecx: 00000000   edx: 0000f0fc
esi: ffffffea   edi: 00000000   ebp: da44bfbc   esp: da44bf98
ds: 007b   es: 007b   ss: 0068
Process plaympeg (pid: 14759, threadinfo=da44a000 task=d8c10a00)
Stack: c0118175 c04e3ce0 b7f31b84 da44a000 00000086 00000000 000039a7 000fffff
       00000000 da44a000 c0103e67 000039a7 00000000 b7af3cf8 000fffff 00000000
       b7af3bcc 0000009c 0000007b 0000007b 0000009c b7dbcd04 00000073 00000246
Call Trace:
 [<c0118175>] setscheduler+0x98/0x1d3
 [<c0103e67>] syscall_call+0x7/0xb
Code: 8b 74 24 04 83 c4 10 c3 81 ea 28 02 10 c0 8b 0d 6c 8f 4e c0 a1 68 8f 4e c0 d3 ea 83 e8 01 39 d0 0f 46 d0 a1 64 8f 4e c0 8d 14 90 <ff> 02 c3 b8 da ff ff ff c3 b8 da ff ff ff c3 90 90 53 31 d2 83
 <6>note: plaympeg[14759] exited with preempt_count 2



also the nvidia 6111 module with gentoo patches doesn't work.

-- 
MyExcuse:
vapors from evaporating sticky-note adhesives

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Thu__7_Oct_2004_11_59_20_+0200_X2v6k38sgw2OScON
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBZRN6mjLYGS7fcG0RArP7AJ9JpTABHtQxlqYsh91dB0Mq4YMq8ACfYeNP
nl0Q2AAuwnQD5YDH3YaYj6k=
=XaIF
-----END PGP SIGNATURE-----

--Signature=_Thu__7_Oct_2004_11_59_20_+0200_X2v6k38sgw2OScON--
