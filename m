Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132790AbQLHVAl>; Fri, 8 Dec 2000 16:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132778AbQLHVA2>; Fri, 8 Dec 2000 16:00:28 -0500
Received: from pop.gmx.net ([194.221.183.20]:27198 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S132790AbQLHVAU>;
	Fri, 8 Dec 2000 16:00:20 -0500
From: Norbert Breun <nbreun@gmx.de>
Reply-To: nbreun@gmx.de
Organization: private
Date: Fri, 8 Dec 2000 21:27:36 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: kernel bug with 2.4.0-test12pre7 at startup
MIME-Version: 1.0
Message-Id: <00120821273600.00818@nmb>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

at startup of 2.4.0-test12pre7 I receive a bug-message as part of the 
following boot.msg. I hope this will be helpfull. If you need more info, let 
me know.

kind regards
Norbert

---------------------------- snip  --------------------------------------
kernel BUG at buffer.c:827!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0134296>]
EFLAGS: 00010286
eax: 0000001c   ebx: c7e78d40   ecx: c0267668   edx: c0267668
esi: c1219768   edi: 00000202   ebp: c7e78d88   esp: c7ea1bd8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 7, stackpage=c7ea1000)
Stack: c02249c5 c0224cfa 0000033b c12b1780 c1296c00 c7e76800 c7e78d40 c016f059
       c7e78d40 00000001 c7e78d40 00000001 00000004 0000002c c016785c c02dbea8
       00000000 c7e78d40 c7e78d40 00000001 00000000 c7ea1c84 c01679d3 00000000
Call Trace: [<c02249c5>] [<c0224cfa>] [<c016f059>] [<c016785c>] [<c01679d3>] 
[<c0135674>] [<c012e823>]
       [<c0155517>] [<c0154dd8>] [<c0126623>] [<c012694b>] [<c0126880>] 
[<c013ba08>] [<c013c06d>] [<c014b0ad>]
       [<c014af10>] [<c0147cad>] [<c0126873>] [<c013c1ee>] [<c0215cad>] 
[<c013c49b>] [<c013c4b2>] [<c010954b>]
       [<c010abf7>] [<c0215cba>] [<c01070c5>] [<c0215cba>] [<c0109130>] 
[<c0215cba>]
Code: 0f 0b 83 c4 0c 90 8d 74 26 00 8d 5e 28 8d 46 2c 39 46 2c 74

------------------------- snap -------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
