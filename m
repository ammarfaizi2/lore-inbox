Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264343AbTLVOnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 09:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbTLVOnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 09:43:03 -0500
Received: from imap.gmx.net ([213.165.64.20]:746 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264343AbTLVOnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 09:43:00 -0500
X-Authenticated: #2112340
From: <desman@gmx.de>
To: <linux-kernel@vger.kernel.org>
Subject: kernel: kernel BUG at page_alloc.c:105!   ---   Kernel is 2.4.23
Date: Mon, 22 Dec 2003 15:45:12 +0100
Message-ID: <PFEJKJJNJPHILNAIAJDDEEAADLAA.desman@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

here the Syslog:

Dec 22 06:42:26 vserver4 kernel: kernel BUG at page_alloc.c:105!
Dec 22 06:42:26 vserver4 kernel: invalid operand: 0000
Dec 22 06:42:26 vserver4 kernel: CPU:    0
Dec 22 06:42:26 vserver4 kernel: EIP:    0010:[<c012aa34>]    Not tai
Dec 22 06:42:26 vserver4 kernel: EFLAGS: 00010286
Dec 22 06:42:26 vserver4 kernel: eax: c02b4d74   ebx: c236bc20   ecx:
 edx: 00000003
Dec 22 06:42:26 vserver4 kernel: esi: 00000000   edi: 00000002   ebp:
 esp: c2825f1c
Dec 22 06:42:26 vserver4 kernel: ds: 0018   es: 0018   ss: 0018
Dec 22 06:42:26 vserver4 kernel: Process kswapd (pid: 4, stackpage=c2
Dec 22 06:42:26 vserver4 kernel: Stack: ebbdd140 c236bc20 00000002 00
536e c236bc20 000001d0 00000002
Dec 22 06:42:26 vserver4 kernel:        00000c80 c01335f9 ebbdd140 c2
a102 c012b39b c012a13b 00000020
Dec 22 06:42:26 vserver4 kernel:        000001d0 c02b4c98 c02b4c98 c2
fe83 000001d0 c02b4c98 c012a40f
Dec 22 06:42:26 vserver4 kernel: Call Trace:    [<c013536e>] [<c01335
a102>] [<c012b39b>] [<c012a13b>]
Dec 22 06:42:27 vserver4 kernel:   [<c012a40f>] [<c012a480>] [<c012a6
a686>] [<c012a7bd>] [<c01055c8>]
Dec 22 06:42:27 vserver4 kernel:
Dec 22 06:42:27 vserver4 kernel: Code: 0f 0b 69 00 81 55 26 c0 89 d8
 31 c0 69 c0 ab aa

kswapd is at moment going as a zombie.

Kernel is 2.4.23

Greetings
oliver

