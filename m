Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311650AbSDIV0n>; Tue, 9 Apr 2002 17:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311664AbSDIV0m>; Tue, 9 Apr 2002 17:26:42 -0400
Received: from sebula.traumatized.org ([193.121.72.130]:5508 "EHLO
	sparkie.is.traumatized.org") by vger.kernel.org with ESMTP
	id <S311650AbSDIV0l>; Tue, 9 Apr 2002 17:26:41 -0400
Date: Tue, 9 Apr 2002 23:20:00 +0200
From: Jurgen Philippaerts <jurgen@pophost.eunet.be>
To: linux-kernel@vger.kernel.org
Subject: arch/sparc64/kernel/traps.c
Message-ID: <20020409212000.GK9996@sparkie.is.traumatized.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i (Linux 2.4.19-pre5 sparc64)
X-Files: the truth is out there
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i recently wanted to check something in my `dmesg` output.
but i saw something i didn't expect :)

i do not know how long it's been there, since i don't check it that
often, but... do i need to worry about something ?

FWIW; this was 2.4.19-pre5 on a sunblade100


this is what i got:

data_access_exception: SFSR[0000000000801009] SFAR[fffffd0000000028],
going.
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
find(4631): Dax
TSTATE: 0000009911009601 TPC: 00000000005a39c0 TNPC: 00000000005a39c4
Y: 00000000    Not tainted
g0: 0000000000000000 g1: 0000000000000084 g2: 0000000000000001 g3:
fffff800002131c0
g4: fffff80000000000 g5: 0000000000000001 g6: fffff80001ec4000 g7:
0000000000000001
o0: 0000000000000001 o1: 00fcfd0000000028 o2: 0000000000008027 o3:
0000000000000009
o4: fffff8002075b78a o5: 0000000019999997 sp: fffff80001ec7211
ret_pc: 0000000000486cac
l0: 0000000000000027 l1: fffff800263f7740 l2: 00fcfd0000000000 l3:
fffff80027ed5f50
l4: 000000000001aa6c l5: 0000000000000000 l6: fffff80024ac6000 l7:
0000000000000000
i0: fffff80007782620 i1: fffff8002075b6e0 i2: 00000000005d5158 i3:
0000000000486bc0
i4: 000000007015f0ec i5: 000000007015f0ec i6: fffff80001ec72d1 i7:
00000000004730a8
Caller[00000000004730a8]
Caller[0000000000473a24]
Caller[0000000000473d2c]
Caller[0000000000474268]
Caller[00000000004703ec]
Caller[00000000004112f4]
Caller[00000000700fc9cc]
Instruction DUMP: 00000000  00000000  00000000 <ca024000> 8e014008
cfe25005  80a14007  1247fffc  8143e00a


Jurgen.
