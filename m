Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262650AbSJBWxN>; Wed, 2 Oct 2002 18:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262686AbSJBWxN>; Wed, 2 Oct 2002 18:53:13 -0400
Received: from main.davidkarlsen.com ([217.13.8.30]:53008 "EHLO
	cluster-A.davidkarlsen.com") by vger.kernel.org with ESMTP
	id <S262650AbSJBWxF>; Wed, 2 Oct 2002 18:53:05 -0400
Message-ID: <3D9B7A15.80902@davidkarlsen.com>
Date: Thu, 03 Oct 2002 00:58:29 +0200
From: "David J. M. Karlsen" <david@davidkarlsen.com>
Organization: davidkarlsen.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: nb, no, nn, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sparcstation-II crashing on 2.4.19
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sep 26 06:27:38 spank kernel: Unable to handle kernel paging request in 
mna hand
ler<1> at virtual address 119000c3 

Sep 26 06:27:38 spank kernel: current->{mm,active_mm}->context = 
00000007
Sep 26 06:27:38 spank kernel: current->{mm,active_mm}->pgd = f1468000 

Sep 26 06:27:38 spank kernel:               \|/ ____ \|/ 

Sep 26 06:27:38 spank kernel:               "@'/ ,. \`@" 

Sep 26 06:27:38 spank kernel:               /_| \__/ |_\ 

Sep 26 06:27:38 spank kernel:                  \__U_/ 

Sep 26 06:27:38 spank kernel: start-stop-daem(10401): Oops 

Sep 26 06:27:38 spank kernel: PSR: 11000fc2 PC: f0199058 NPC: f019905c 
Y: b40000
00    Not tainted 

Sep 26 06:27:38 spank kernel: g0: f00729a4 g1: 119000c3 g2: 00000001 g3: 
110000e
3 g4: f007239c g5: 00003700 g6: ff050000 g7: 11000fe3 

Sep 26 06:27:38 spank kernel: o0: ff016000 o1: f206d770 o2: 119000c3 o3: 
f021540
0 o4: 00001fff o5: 00000680 sp: ff051c58 o7: f00715d0 

Sep 26 06:27:38 spank kernel: l0: 00000001 l1: f3fe0000 l2: f206d770 l3: 
f3fe0f6
8 l4: 00000000 l5: 00003700 l6: ff050000 l7: e01652ac 

Sep 26 06:27:38 spank kernel: i0: fffffffe i1: ff051d24 i2: ff051d20 i3: 
0000000
2 i4: 00000010 i5: f0196ff0 fp: ff051cc0 i7: f00717b8 

Sep 26 06:27:38 spank kernel: Caller[f00717b8] 

Sep 26 06:27:38 spank kernel: Caller[f0071d50] 

Sep 26 06:27:38 spank kernel: Caller[f005b19c] 

Sep 26 06:27:38 spank kernel: Caller[f005b33c] 

Sep 26 06:27:38 spank kernel: Caller[f005b908] 

Sep 26 06:27:38 spank kernel: Caller[f0057784] 

Sep 26 06:27:38 spank kernel: Caller[f001315c] 

Sep 26 06:27:38 spank kernel: Caller[e00f961c] 

Sep 26 06:27:38 spank kernel: Instruction DUMP: 01000000  01000000 
01000000 <ce
004000> 8401c002  c4204000  8188e000  01000000  01000000 

Sep 26 12:56:48 spank kernel: Unable to handle kernel paging request in 
mna hand
ler<1> at virtual address 119000c3 

Sep 26 12:56:49 spank kernel: current->{mm,active_mm}->context = 
0000000a
Sep 26 12:56:49 spank kernel: current->{mm,active_mm}->pgd = f0834000 

Sep 26 12:56:49 spank kernel:               \|/ ____ \|/ 

Sep 26 12:56:49 spank kernel:               "@'/ ,. \`@" 

Sep 26 12:56:49 spank kernel:               /_| \__/ |_\ 

Sep 26 12:56:49 spank kernel:                  \__U_/ 

Sep 26 12:56:49 spank kernel: lsof(12139): Oops 

Sep 26 12:56:49 spank kernel: PSR: 11000fc4 PC: f0199058 NPC: f019905c 
Y: 1e0000
00    Not tainted 

Sep 26 12:56:49 spank kernel: g0: 00000001 g1: 119000c3 g2: 00000001 g3: 
110000e
5 g4: f007239c g5: 00637764 g6: ff010000 g7: 11000fe5 

Sep 26 12:56:49 spank kernel: o0: ff016000 o1: f206d870 o2: 119000c3 o3: 
f021540
0 o4: 00001fff o5: 00000780 sp: ff011c58 o7: f00715d0 

Sep 26 12:56:49 spank kernel: l0: 00000002 l1: f3fe0000 l2: f206d870 l3: 
f3fe804
0 l4: 00000000 l5: 00637764 l6: ff010000 l7: e01652ac 

Sep 26 12:56:49 spank kernel: i0: fffffffe i1: ff011d24 i2: ff011d20 i3: 
0000000
2 i4: 00000010 i5: f0196ff0 fp: ff011cc0 i7: f00717b8 

Sep 26 12:56:49 spank kernel: Caller[f00717b8] 

Sep 26 12:56:49 spank kernel: Caller[f0071d50] 

Sep 26 12:56:49 spank kernel: Caller[f005b19c] 

Sep 26 12:56:49 spank kernel: Caller[f005b33c] 

Sep 26 12:56:49 spank kernel: Caller[f005b908] 

Sep 26 12:56:49 spank kernel: Caller[f0057784] 

Sep 26 12:56:49 spank kernel: Caller[f001315c] 

Sep 26 12:56:49 spank kernel: Caller[e00f961c] 

Sep 26 12:56:49 spank kernel: Instruction DUMP: 01000000  01000000 
01000000 <ce
004000> 8401c002  c4204000  8188e000  01000000  01000000 

Sep 26 12:56:50 spank kernel: Unable to handle kernel paging request in 
mna hand
ler<1> at virtual address 119000c3 

Sep 26 12:56:50 spank kernel: current->{mm,active_mm}->context = 
00000002
Sep 26 12:56:50 spank kernel: current->{mm,active_mm}->pgd = f3f2d000 

Sep 26 12:56:50 spank kernel:               \|/ ____ \|/ 

Sep 26 12:56:50 spank kernel:               "@'/ ,. \`@" 

Sep 26 12:56:50 spank kernel:               /_| \__/ |_\ 

Sep 26 12:56:50 spank kernel:                  \__U_/ 

Sep 26 12:56:50 spank kernel: lsof(12142): Oops 

Sep 26 12:56:50 spank kernel: PSR: 11000fc1 PC: f0199058 NPC: f019905c 
Y: 000000
00    Not tainted 

Sep 26 12:56:50 spank kernel: g0: f3f2c068 g1: 119000c3 g2: 00000001 g3: 
110000e
2 g4: e00f961c g5: 00637764 g6: ff010000 g7: 11000fe2 

Sep 26 12:56:50 spank kernel: o0: ff016000 o1: efffd950 o2: 119000c3 o3: 
efffda4
0 o4: 0004cba1 o5: 64006400 sp: ff011c58 o7: f00715d0 

Sep 26 12:56:50 spank kernel: l0: 00000002 l1: f006489c l2: f00648a0 l3: 
0000000
4 l4: 00000000 l5: 00637764 l6: ff010000 l7: e01652ac 

Sep 26 12:56:50 spank kernel: i0: fffffffe i1: ff011d24 i2: ff011d20 i3: 
0000000
0 i4: 00035f3b i5: 63776400 fp: ff011cc0 i7: f00717b8 

Sep 26 12:56:50 spank kernel: Caller[f00717b8] 

Sep 26 12:56:50 spank kernel: Caller[f0071d50] 

Sep 26 12:56:50 spank kernel: Caller[f005b19c] 

Sep 26 12:56:50 spank kernel: Caller[f005b33c] 

Sep 26 12:56:50 spank kernel: Caller[f005b908] 

Sep 26 12:56:50 spank kernel: Caller[f0057784] 

Sep 26 12:56:50 spank kernel: Caller[f001315c] 

Sep 26 12:56:50 spank kernel: Caller[e00f961c] 

Sep 26 12:56:50 spank kernel: Instruction DUMP: 01000000  01000000 
01000000 <ce
004000> 8401c002  c4204000  8188e000  01000000  01000000 

Sep 26 12:57:24 spank kernel: Unable to handle kernel paging request in 
mna hand
ler<1> at virtual address 119000c3


vanilla kernel - any more I can provide for debugging causes?


-- 
David J. M. Karlsen
http://www.davidkarlsen.com - http://mp3.davidkarlsen.com
+47 90 68 22 43

