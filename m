Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbSKGPKa>; Thu, 7 Nov 2002 10:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261223AbSKGPKa>; Thu, 7 Nov 2002 10:10:30 -0500
Received: from holomorphy.com ([66.224.33.161]:5285 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261218AbSKGPKa>;
	Thu, 7 Nov 2002 10:10:30 -0500
Date: Thu, 7 Nov 2002 07:15:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: ether buglet
Message-ID: <20021107151509.GL19821@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CPU:    0  
EIP:    0060:[<c013ce56>]    Not tainted
EFLAGS: 00000202
EIP is at kmalloc+0xb2/0x124
eax: 00000001   ebx: ef5fd3e0   ecx: 00000730   edx: ecedd0cf
esi: ecedd000   edi: ecedd000   ebp: eca5be50   esp: eca5be44
ds: 0068   es: 0068   ss: 0068                               
Process ifconfig (pid: 369, threadinfo=eca5a000 task=ed255140)
Stack: ecd25ea8 c03fb980 00000020 eca5be70 c01f6bda 000006c0 00000020 c3e65180 
       0000000d 0000009c 00000246 eca5be94 c01d96f1 00000620 00000020 c3e65180 
       00000000 f8901000 c3e65198 c3e65d98 eca5beb4 c01d927f c3e65000 c3e65000 
Call Trace:                                                                    
 [<c01f6bda>] alloc_skb+0xe2/0x1cc
 [<c01d96f1>] init_ring+0x95/0x1c0
 [<c01d927f>] netdev_open+0x1c7/0x3a0
 [<c01f9cea>] dev_open+0x52/0xac     
 [<c01fb031>] dev_change_flags+0x59/0x110
 [<c022dd94>] devinet_ioctl+0x294/0x57c  
 [<c02305b7>] inet_ioctl+0x77/0xb8     
 [<c01f3fce>] sock_ioctl+0x2ca/0x320
 [<c015e655>] sys_ioctl+0x265/0x2ca 
 [<c0109951>] error_code+0x2d/0x38 
 [<c0108f0f>] syscall_call+0x7/0xb
           
Code: f6 83 b1 00 00 00 04 74 2c b8 a5 c2 0f 17 87 07 3d 71 f0 2c
