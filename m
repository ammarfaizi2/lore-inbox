Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTKCSjm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 13:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTKCSjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 13:39:42 -0500
Received: from law9-f105.law9.hotmail.com ([64.4.9.105]:47628 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262129AbTKCSji
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 13:39:38 -0500
X-Originating-IP: [195.226.230.50]
X-Originating-Email: [hitman1_fm@hotmail.com]
From: "Faisal Malallah" <hitman1_fm@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.22 oops with visor.o and pppd
Date: Mon, 03 Nov 2003 21:39:37 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW9-F105snqHs4rVPX0001384e@hotmail.com>
X-OriginalArrivalTime: 03 Nov 2003 18:39:37.0464 (UTC) FILETIME=[D5764780:01C3A239]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to link my Palm Tungsten T to linux through USB using pppd to 
establish a network connection, the connection goes well for a while but 
then it disconnects and the kernel oops.

Using Kernel 2.4.22 on redhat 9
pppd version 2.4.1

pppd[1936]: IPCP terminated by peer
pppd[1936]: LCP terminated by peer
kernel: usb-uhci.c: interrupt, status 3, frame# 1614
kernel: usb.c: USB disconnect on device 00:1d.0-1 address 3
kernel: visor.c: Bytes In = 296  Bytes Out = 303
kernel: Unable to handle kernel NULL pointer
dereference at virtual address 000009a4
kernel:  printing eip:
kernel: f9e2d27c
kernel: *pde = 00000000
kernel: Oops: 0002
kernel: CPU:    0
kernel: EIP:    0010:[<f9e2d27c>]    Tainted: PF
kernel: EFLAGS: 00010246
kernel: eax: 00000000   ebx: f60cc400   ecx: 00000000  edx: 00000000
kernel: esi: f60cc41c   edi: 00000000   ebp: f60cc400  esp: f7681f14
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process khubd (pid: 71, stackpage=f7681000)
kernel: Stack: f60cc41c 00000000 f88833f4 f9e2eea0 f9e2ee80 00000000 
c28cd940 f8878300
kernel:        f5e9d400 f60cc400 f5e9d404 00000003 00000000 f5e9d400 
00000100 0000000a
kernel:        f76b3000 00000000 f887b3d0 f76b3110 00000001 00000010 
f76b3000 f887adfc
kernel: Call Trace:    [<f88833f4>] [<f9e2eea0>] [<f9e2ee80>] [<f8878300>] 
[<f887b3d0>]
kernel:   [<f887adfc>] [<f887b710>] [<f887b7d5>] [<f887b790>] [<c010762e>] 
[<f887b790>]
kernel:
kernel: Code: 89 90 a4 09 00 00 8d 4e 5c f0 ff 43 78 0f 8e d5 05 00 00 0f
kernel:  <6>note: khubd[71] exited with preempt_count 1

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

