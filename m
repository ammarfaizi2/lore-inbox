Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130102AbRBILCc>; Fri, 9 Feb 2001 06:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130411AbRBILCW>; Fri, 9 Feb 2001 06:02:22 -0500
Received: from brooks.civeng.adelaide.edu.au ([129.127.78.254]:23941 "EHLO
	brooks.civeng.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S130102AbRBILCT>; Fri, 9 Feb 2001 06:02:19 -0500
From: "Stephen Carr" <sgcarr@civeng.adelaide.edu.au>
To: linux-kernel@vger.kernel.org
Date: Fri, 9 Feb 2001 21:30:58 +1030
Subject: Panic from 2.4.2-pre2 kernel - output #2
Reply-to: sgcarr@civeng.adelaide.edu.au
Message-ID: <3A846192.8115.2402613@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All

Another panic - not the same cause

Regards
Stephen Carr

---------------------------------
Welcome to Linux 2.4.2-pre2.

elizabeth login: sgcarr
Password:
Linux 2.4.2-pre2.
Last login: Fri Feb  9 21:05:18 +1030 2001 on ttyp0 from lise.
No mail.
elizabeth.[~] sudo -s
Password:
elizabeth.[~] /usr/local/scripts/level0l
st0: Block limits 1 - 16777215 bytes.
invalid operand: 0000
CPU:    0
EIP:    0010:[<c011a730>]
EFLAGS: 00010016
eax: 2cc7b82e   ebx: cbf89970   ecx: 00000246   edx: 0000004b
esi: cbf89960   edi: 00000000   ebp: c02a5f34   esp: c02a5ee4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02a5000)
Stack: cc1d1af8 c011a718 cbf89970 c01f36d8 cbf89970 cc1d1af8 
cbf89960 cc1d1a00
       d0826e30 cbf89960 c15b4050 cc1d1a00 cfdddec0 cbfefd00 
cbba8300 cc1d1af8
       cc1d1e00 00000001 cc12582c 0000000e c02a5f58 d08266a5 
cfdddec0 c15bb380
Call Trace: [<c011a718>] [<c01f36d8>] [<d0826e30>] 
[<d08266a5>] [<c010a769>] [<c
010a95e>] [<c01071c0>]
       [<c01071c0>] [<c01090b8>] [<c01071c0>] [<c01071c0>] 
[<c0100018>] [<c01071
ec>] [<c010724e>] [<c0105000>]
       [<c01001d0>]

Code: ff ff b8 00 e0 ff ff 21 e0 89 f2 83 c2 04 19 ff 39 50 0c 83
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
NMI Watchdog detected LOCKUP on CPU1, registers:
CPU:    1
EIP:    0010:[<c0107f2b>]
EFLAGS: 00000087
eax: c028f628   ebx: c15fff7c   ecx: c15fe000   edx: c15fff7c
esi: 20000001   edi: 00000020   ebp: 00000000   esp: c15fff20
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c15ff000)
Stack: c022e666 c010d850 c028dcd4 00000005 c010a769 
00000000 00000000 c15fff7c
       00000000 c02d9800 00000000 c15fff74 c010a95e 00000000 
c15fff7c c028dcd4
       c01071c0 c15fe000 c01071c0 c028dcd4 00000001 00000000 
c01090b8 c01071c0
Call Trace: [<c022e666>] [<c010d850>] [<c010a769>] 
[<c010a95e>] [<c01071c0>] [<c
01071c0>] [<c01090b8>]
       [<c01071c0>] [<c01071c0>] [<c0100018>] [<c01071ec>] 
[<c010724e>] [<c011ae
8a>] [<c010a99f>]

Code: 81 38 00 00 00 01 75 f8 f0 81 28 00 00 00 01 75 e8 c3 8d 76
console shuts up ...

-----------------
Computing Officer
Department of Civil and Environmental Engineering
University of Adelaide
Adelaide, South Australia,
Australia 5005
Phone +618 8303-4313
Fax   +618 8303-4359
Email sgcarr@civeng.adelaide.edu.au
-----------------------------------------------------------
This email message is intended only for the addressee(s)
and contains information which may be confidential and/or
copyright.  If you are not the intended recipient please
do not read, save, forward, disclose, or copy the contents
of this email. If this email has been sent to you in error,
please notify the sender by reply email and delete this
email and any copies or links to this email completely and
immediately from your system.  No representation is made
that this email is free of viruses.  Virus scanning is
recommended and is the responsibility of the recipient.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
