Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbSKTIoB>; Wed, 20 Nov 2002 03:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265947AbSKTIoA>; Wed, 20 Nov 2002 03:44:00 -0500
Received: from redrock.inria.fr ([138.96.248.51]:40846 "HELO redrock.inria.fr")
	by vger.kernel.org with SMTP id <S265885AbSKTInY>;
	Wed, 20 Nov 2002 03:43:24 -0500
To: linux-kernel@vger.kernel.org
Subject: Fw: Troubles with Sony PCG-C1MHP (crusoe based and ALIM 1533 drivers)
SCF: #mh/Mailbox/outboxDate: Wed, 20 Nov 2002 09:41:21 +0100
From: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
Message-Id: <20021120094121.7b6c7d34.Manuel.Serrano@sophia.inria.fr>
Organization: Inria
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: 20 Nov 2002 09:44:04 +0100
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For information, 

I have tried the new linux-2.4.20-rc2-ac1 version and it shows the
same problems as 2.4.20-rc1-ac4. That is, the kernel does not boot
with the following message:

-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
ALI15x3: simplex device: DMA forced
ide1: bm-dma at 0x1400-0x140f, BIOS settings: hdc: DMA, hdd: DMA
blk: queue c029d6a0, I/O limit 4095MB (mask 0xffff..ff)
unable to handle kernel NULL pointer dereference at vistual address 00000010
printing eip:Nc0107cab
*pde = 000000000N
Oops: 0000
CPU: 0
EIP: 0010:[<c0107cab>] no tainted
EFLAGS: 00010002
eax: 00000000 ebx: 00001fe0 ecx: 000000001 edx: 000000ff
esi: 00000212 edi: c029da4v ebp: 0000000ff esp: c1a13f64
s: 0018 es: 0018 ss: 0018
Process swapper (pid: 1, stackpage=c1a30000)
stack: 0000000ff 0000000001 ....
call Trace: [<c019ee85>] [<c019fa98>] [<c0105021>] [<c01054a9>]
code: 8b 40 10 ff d0 83 c4 04 56 9d 83 3d 84 dc 27 c0 00 75 0f 89
<0>kernel panic: Attempted to kill init
-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----

Sincerely,

-- 
Manuel
