Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130053AbRCDPSI>; Sun, 4 Mar 2001 10:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130054AbRCDPR5>; Sun, 4 Mar 2001 10:17:57 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:58658 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S130053AbRCDPRs>; Sun, 4 Mar 2001 10:17:48 -0500
Message-ID: <3AA25C25.ADE552F1@mail.dotcom.fr>
Date: Sun, 04 Mar 2001 16:15:49 +0100
From: Romain Chantereau <romainc@mail.dotcom.fr>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-fidel i586)
X-Accept-Language: fr-FR, fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel error..
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I didn't know where send this bug report, so I send it here as writen in
the Doc... Sorry if I mistake...

Ok, I have a Debian sid (sic), on a AMD K6-2 300, on a Asus P5A, I have
enabled AGP etc...
Ah ! My graphic card is a Riva TNT, and I use it with the Nvidia driver
0.9.6..

Ok, let's talk about the problem: That's it :

(fidel is my computer name)

fidel login: Unable to handle kernel paging request at virtual address
18297044
 printing eip:
 c6a9ed43
 *pde = 00000000
 Oops: 0002
 CPU:    0
 EIP:    0010:[<c6a9ed43>]
 EFLAGS: 00013246
 eax: 18297044   ebx: c58cfa1f   ecx: 00000000   edx: 00000001
 esi: c14b8220   edi: 00000000   ebp: c1643e18   esp: c1643e0c
 ds: 0018   es: 0018   ss: 0018
 Process X (pid: 658, stackpage=c1643000)
 Stack: c14b83e0 cbb2f004 c1f96204 c1643e34 c6a9f0af cbb2f004 c14b8220
c58cfa20
        c14b83e0 c58cf9f0 c1643e50 c6a9741a cbb2f004 c58cf9f0 c14b83e0
00000000
        00000000 c1643e74 c6a9c0df cbb2f004 c58cf9f0 00000001 00000101
c14b83e0
Call Trace: [<cbb2f004>] [<c6a9f0af>] [<cbb2f004>] [<c6a9741a>]
[<cbb2f004>] [<c6a9c0df>] [<cbb2f004>]
       [<c6a9bc35>] [<cbb2f004>] [<cbb2f004>] [<c6a9bac2>] [<c6b142f8>]
[<c0164f6a>] [<c6a98590>] [<c6a95dab>]
       [<c6b14080>] [<c6b14080>] [<c6a9567d>] [<c0130d50>] [<c012ffcb>]
[<c0118448>] [<c0118a2f>] [<c0118bc2>]
       [<c0108e13>]

Code: 08 14 38 46 89 d8 4b 85 c0 75 e4 8d 65 f4 5b 5e 5f c9 c3 89


My computer use to crash a short time after if I don't reboot...

ouch !

Thanks for your reply, or return receipt, good luck,

vala

romain

