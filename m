Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbUCFOTg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 09:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUCFOTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 09:19:36 -0500
Received: from real-outmail.cc.huji.ac.il ([132.64.1.17]:39046 "EHLO
	mail1.cc.huji.ac.il") by vger.kernel.org with ESMTP id S261671AbUCFOTf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 09:19:35 -0500
Message-ID: <4049DDF3.5080500@mscc.huji.ac.il>
Date: Sat, 06 Mar 2004 16:19:31 +0200
From: Voicu Liviu <pacman@mscc.huji.ac.il>
Reply-To: Voicu Liviu <pacman@mscc.huji.ac.il>
Organization: Hebrew University of Jerusalem
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040206
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6-use-register-arguments.patch
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xe0000000
fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, 
Starnberg, GERMANY' taints kernel.
Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
e09c08a0
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<e09c08a0>]    Tainted: P
EFLAGS: 00010246
EIP is at firegl_init+0x40/0x100 [fglrx]
eax: e09e50c0   ebx: 00000000   ecx: 00000002   edx: e09e50e0
esi: e09e4cc0   edi: e09e5110   ebp: c02e6e38   esp: dfab1f60
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2631, threadinfo=dfab0000 task=c166a0c0)
Stack: 00000282 e09e50c0 e09e50c0 e08fe255 00000000 00000000 00000019 
00000018
        e09b1994 e09a0268 e09a035c e0977000 08059798 4017d008 c02e6e50 
c02e6e50
        dfab0000 c01330b8 ffff0001 dfab0000 4017d008 400a022f 4015ac80 
dfab0000
Call Trace:
  [<e08fe255>] firegl_init_module+0xe5/0x180 [fglrx]
  [<c01330b8>] sys_init_module+0xe8/0x1f0
  [<c01091a7>] syscall_call+0x7/0xb
