Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265381AbRF0TVb>; Wed, 27 Jun 2001 15:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265379AbRF0TVM>; Wed, 27 Jun 2001 15:21:12 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:55569 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S265376AbRF0TVK>; Wed, 27 Jun 2001 15:21:10 -0400
From: "Soeren Sonnenburg" <sonnenburg@informatik.hu-berlin.de>
To: <linux-kernel@vger.kernel.org>
Subject: kernel BUG at inode.c:486! (2.4.5)
Date: Wed, 27 Jun 2001 21:14:26 +0200
Message-ID: <NCBBIODJDAHHMNHHMKLACEMNFFAA.sonnenburg@informatik.hu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happens here from time to time :-(

Is it fixed in some 2.4.6preX ?

Soeren.

==========snip============

kernel BUG at inode.c:486!
invalid operand: 0000
CPU:    0
EIP:    0010:[load_aout_library+19/640]
EFLAGS: 00010286
eax: 0000001b   ebx: e43baa80   ecx: d7f54000   edx: e3801ac0
esi: c029f200   edi: e3e57940   ebp: d7f55fa4   esp: d7f55edc
ds: 0018   es: 0018   ss: 0018
Process latex (pid: 24761, stackpage=d7f55000)
Stack: c024ab70 c024abcf 000001e6 e43baa80 c0142df7 e43baa80 e2ea6240
e43baa80
       c01689fd e43baa80 c01406f6 e2ea6240 e43baa80 e2ea6240 00000000
c01390e8
       e2ea6240 d7f55f58 c013982a e3e57940 d7f55f58 00000000 c780e000
00000000
Call Trace: [proc_read_status+439/464] [nfs3svc_decode_sattrargs+381/512]
[get_new_inode+278/352] [vfs_rename_dir+248/1216] [sys_rename+42/528]
[sys_link+10/304] [expand_files+60/80]
       [put_last_free+109/112] [system_call+51/56]

Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 1f 68 e8 01 00 00 68
kernel BUG at inode.c:486!
invalid operand: 0000
CPU:    0
EIP:    0010:[load_aout_library+19/640]
EFLAGS: 00010286
eax: 0000001b   ebx: e40fb980   ecx: cb270000   edx: e3801ac0
esi: c029f200   edi: e2ea63c0   ebp: cb271fa4   esp: cb271e64
ds: 0018   es: 0018   ss: 0018
Process latex (pid: 24762, stackpage=cb271000)
Stack: c024ab70 c024abcf 000001e6 e40fb980 c0142df7 e40fb980 e2ea6c40
e40fb980
       c01689fd e40fb980 c01406f6 e2ea6c40 e40fb980 e2ea6c40 00000000
c01390e8
       e2ea6c40 cb271ee0 c013982a e2ea63c0 cb271ee0 00000000 cb271fa4
c1cca340
Call Trace: [proc_read_status+439/464] [nfs3svc_decode_sattrargs+381/512]
[get_new_inode+278/352] [vfs_rename_dir+248/1216] [sys_rename+42/528]
[fifo_open+167/592] [nfs3svc_decode_renameargs+9/5
       [sys_rename+378/528] [expand_files+60/80] [put_last_free+109/112]
[system_call+51/56]

Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 1f 68 e8 01 00 00 68
kernel BUG at inode.c:486!
invalid operand: 0000
CPU:    0
EIP:    0010:[load_aout_library+19/640]
EFLAGS: 00010286
eax: 0000001b   ebx: c7743cc0   ecx: cb270000   edx: e3801ac0
esi: c029f200   edi: e2ea65c0   ebp: cb271fa4   esp: cb271edc
ds: 0018   es: 0018   ss: 0018
Process latex (pid: 24763, stackpage=cb271000)
Stack: c024ab70 c024abcf 000001e6 c7743cc0 c0142df7 c7743cc0 e2ea66c0
c7743cc0
       c01689fd c7743cc0 c01406f6 e2ea66c0 c7743cc0 e2ea66c0 00000000
c01390e8
       e2ea66c0 cb271f58 c013982a e2ea65c0 cb271f58 00000000 d93d2000
00000000
Call Trace: [proc_read_status+439/464] [nfs3svc_decode_sattrargs+381/512]
[get_new_inode+278/352] [vfs_rename_dir+248/1216] [sys_rename+42/528]
[sys_link+10/304] [expand_files+60/80]
       [put_last_free+109/112] [system_call+51/56]

Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 1f 68 e8 01 00 00 68
==========snip============
--
"Ein Sprichwort der Prols sagt: Ist der Mensch wissend geworden, steht
unvermittelt sein Ende bevor. Vielleicht ist es weiser unwissend zu
bleiben..."
"Wissen hat irgendwann ein Ende, Nichtwissen ist unendlich. Zweifeln sie
etwa am Grossen Bruder, 87155 Barnes P?" (aus Bruder OZ/AC)

