Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289226AbSA2NOC>; Tue, 29 Jan 2002 08:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288845AbSA2NNx>; Tue, 29 Jan 2002 08:13:53 -0500
Received: from newton.math.uni-mannheim.de ([134.155.89.79]:39385 "EHLO
	newton.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S288810AbSA2NNj>; Tue, 29 Jan 2002 08:13:39 -0500
Message-Id: <7624197.q1iQU4070A@newssend.sf-tec.de>
From: Rolf Eike Beer <eike@euklid.math.uni-mannheim.de>
Subject: [2.5.3-pre5] BUG on boot
To: linux-kernel@vger.kernel.org
Date: Tue, 29 Jan 2002 14:14:19 +0100
User-Agent: KNode/0.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday I tried to boot 2.5.3-pre5 on my Compaq ProSignia 
(486DX2-66,36MB RAM, SCSI-only).

Output written down from screen, so maybe threre is a typo. If someone 
needs .config or something more just ask.

devfs: V1.10 ( 20020120) ...
devfs: boot_options: 0x1
Kernel BUG ar slab.c: 641
invalid operand: 0000
CPU: 0
EIP: 0010:[<c0125398>] Not tainted
EFLAGS: 00010286
eax: 0000001a ebx: c023d030 ecx: c0221280 edx: 00000866
esi: 00000184 edi: c01fea28 ebp: 00000000 esp: c10a5f84
ds: 0018 es: 0018 ss: 0018
Process swapper (pid 1: stackpage= c10a5000)
stack: c01ef750 00000281 c023d030 c0231fd4 00000000 0008e000
       c0224aa0 00000000 c0132338 c0224aa0 c023d02c c0231fd4
       c017133d c01fea13 00000184 00000000 00002000 c01712f0
       00000000 c0239326 c023d030 c02326ba 00010f00 c02326f5
Call trace c0132338 c017133d c01712f0 c0105027 c0107078
Code 0f 0b 83 c4 08 8d 76 00 f7 44 24 38 ff 0f ff ff 74 16 68 a0
<0>Kernel panic: attempt to kill init!

Eike
-- 
Es wäre schon wünschenswert, wenn die DAUs das Stück toten Baum, was
mit der Suse mitkommt, nutzen würden. Entweder zum Lesen, oder um sich
damit so lange auf den Schädel zu hauen, bis die Kollegen vom RD
anrücken müssen.        Hauke Heidtmann in feuerwehrmann.talk
