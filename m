Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbTBYAQG>; Mon, 24 Feb 2003 19:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbTBYAQF>; Mon, 24 Feb 2003 19:16:05 -0500
Received: from imo-d08.mx.aol.com ([205.188.157.40]:55479 "EHLO
	imo-d08.mx.aol.com") by vger.kernel.org with ESMTP
	id <S264788AbTBYAQE>; Mon, 24 Feb 2003 19:16:04 -0500
Message-ID: <3E5AB69B.5020907@netscape.net>
Date: Mon, 24 Feb 2003 21:19:39 -0300
From: Fernando R Secco <TByteP@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en, ja, pt-br
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel -2.4.18
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mmap
forget_pte: old mapping existed!
------------[ cut here ]------------
kernel BUG at memory.c:314!
invalid operand: 0000
driver_myrinet nls_iso8859-1 cmpci soundcore ide-cd cdrom agpgart nvidia 
autof
CPU:    0
EIP:    0010:[<c012ac4c>]    Tainted: P
EFLAGS: 00010282

EIP is at remap_page_range [kernel] 0x1ec (2.4.18-14)
eax: 00000021   ebx: c4678458   ecx: de04e000   edx: de04ff7c
esi: dec7c09c   edi: 09aa2067   ebp: 00027000   esp: d2249eec
ds: 0018   es: 0018   ss: 0018
Process pcimap_test (pid: 24867, stackpage=d2249000)
Stack: c0255f20 00214000 f9013000 00214000 f8fec000 00014000 cc047400 
dffd1540
       40214000 cc047400 ffffffea dffd1540 00001000 d2249f40 e1be72e9 
40014000
       b8fec000 00200000 00000027 dffd1540 00000000 ddeb1f40 c012c3d6 
ddeb1f40
Call Trace: [<e1be72e9>] yardriver_mmap [driver_myrinet] 0x3f (0xd2249f24))
[<c012c3d6>] do_mmap_pgoff [kernel] 0x2f6 (0xd2249f44))
[<c010e457>] sys_mmap2 [kernel] 0x77 (0xd2249f94))
[<c01090ff>] system_call [kernel] 0x33 (0xd2249fc0))


Code: 0f 0b 3a 01 62 5a 25 c0 e9 56 ff ff ff 90 8d b6 00 00 00 00
 

-- 
Fernando R Secco
Computer Science Bachelor Student 

Universidade Federal de Santa Catarina
http://www.ufsc.br

SNOW - Parallel Programming Environment for Clustes of Workstations 
http://snow.lisha.ufsc.br

Personal website 
http:// www.lisha.ufsc.br/~secco

nerd things
icq: 30051897
aim: TByteP


