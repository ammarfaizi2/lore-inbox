Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272393AbRH3SVb>; Thu, 30 Aug 2001 14:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272395AbRH3SVW>; Thu, 30 Aug 2001 14:21:22 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:1233 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id <S272393AbRH3SVQ>;
	Thu, 30 Aug 2001 14:21:16 -0400
Organization: 
Date: Thu, 30 Aug 2001 21:19:55 +0300 (EET DST)
From: mythos <papadako@csd.uoc.gr>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with 2.4.9-ac4
Message-ID: <Pine.GSO.4.33.0108302118100.24485-100000@iridanos.csd.uch.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to run con2fb which I use for Dualhead with my Matrox, I get
the following message:
<1>Unable to handle kernel NULL pointer dereference at virtual address
00000024
<4> printing eip:
<4>c01ec349
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[fbcon_setup+857/2656]
<4>EFLAGS: 00010212
<4>eax: 00000080   ebx: 00000008   ecx: 00000007   edx: 00000000
<4>esi: c031e6e4   edi: c031e6e4   ebp: c031e6e4   esp: cf7afd4c
<4>ds: 0018   es: 0018   ss: 0018
<4>Process con2fb (pid: 101, stackpage=cf7af000)
<4>Stack: cff36f62 c01f356c ad55ad55 00000000 c031e180 cff36f64 00000100
0000002e
<4>       00000031 00000000 00000033 cff36f66 cff36f64 cf758200 c031e6e4
c031e180
<4>       cff36f62 00000001 0000002e 0000002f 0000002f 0000002f c1402000
c032350c
<4>Call Trace: [matrox_cfbX_revc+108/192] [fbcon_scroll+1736/2560]
[fbcon_setup+240/2656] [fbcon_deinit+21/64] [fb_mmap+262/336]<4>
[fbcon_vbl_handler+19/144] [do_no_page+135/288] [__pmd_alloc+13/16]
[call_console_drivers+107/256] [printk+228/304] [do_pa<4>
[dentry_open+332/336] [dentry_open+78/336] [sys_ioctl+225/576]
[system_call+51/56]
<4>
<4>Code: 85 42 24 0f 84 14 07 00 00 8b 52 1c 85 d2 74 1a 8b 4c 24 38



