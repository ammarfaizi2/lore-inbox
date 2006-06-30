Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWF3J5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWF3J5y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 05:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWF3J5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 05:57:54 -0400
Received: from LNeuilly-152-21-64-8.w80-15.abo.wanadoo.fr ([80.15.165.8]:2795
	"EHLO serveur2.macsoft-sa.com") by vger.kernel.org with ESMTP
	id S932491AbWF3J5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 05:57:53 -0400
Message-ID: <44A518D7.2060105@free.fr>
Date: Fri, 30 Jun 2006 12:28:07 +0000
From: "s.a." <sancelot@free.fr>
User-Agent: Thunderbird 1.5.0.4 (X11/20060608)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel module debugging question 
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have got the following fault , can you provide me with more details
about the problem ?
Best Regards
Steph

general protection fault: 0000 [#1]
PREEMPT
Modules linked in: nls_iso8859_1 nls_cp437 i915 rtcan_sja1000 e100
usb_storage eepro100 mii rtc unix
CPU:    0
EIP:    0060:[<c0103112>]    Not tainted VLI
EFLAGS: 00010246   (2.6.16.19-ipipe #1)
EIP is at sysenter_exit+0xf/0x11
eax: 00000010   ebx: 00000000   ecx: b7d1223c   edx: ffffe410
esi: b7d122cc   edi: 00000000   ebp: 00000000   esp: dc1a7fbc
ds: 007b   es: 007b   ss: 0068
Process EnvoiPDO0 (pid: 1879, threadinfo=dc1a6000 task=de35d030)
Stack: <0>00000000 b7d122cc 00000000 b7d122cc 00000000 b7d12268 00000010
0000007b
       0000007b 0802022b ffffe410 00000073 00000206 b7d1223c 0000007b
00000000
       00000000
Call Trace:
Code: 44 24 18 e8 81 ca 03 00 fb 8b 4d 08 66 f7 c1 ff fe 0f 85 4e 01 00
00 e8 ed ea 00 00 8b 44 24 18 8b 54 24 28 8b 4c 24 34 31 ed fb <0f> 35
50 fc 06 1e 50 55 57 56 52 51 53 ba 7b 00 00 00 8e da 8e
 <0>general protection fault: 0000 [#2]
PREEMPT
Modules linked in: nls_iso8859_1 nls_cp437 i915 rtcan_sja1000 e100
usb_storage eepro100 mii rtc unix
CPU:    0
EIP:    0060:[<c0103112>]    Not tainted VLI
EFLAGS: 00010246   (2.6.16.19-ipipe #1)
EIP is at sysenter_exit+0xf/0x11
eax: 00000000   ebx: 00000000   ecx: b7ce6a2c   edx: ffffe410
esi: 00669627   edi: 00000000   ebp: 00000000   esp: d704ffbc
ds: 007b   es: 007b   ss: 0068
Process Automat (pid: 1882, threadinfo=d704e000 task=d701b030)
Stack: <0>00000000 00000001 b7d8a660 00669627 00000000 b7ce6a58 00000000
2801007b
       0000007b 0801022b ffffe410 00000073 00000206 b7ce6a2c 0000007b
00000000
       00000000
Call Trace:
Code: 44 24 18 e8 81 ca 03 00 fb 8b 4d 08 66 f7 c1 ff fe 0f 85 4e 01 00
00 e8 ed ea 00 00 8b 44 24 18 8b 54 24 28 8b 4c 24 34 31 ed fb <0f> 35
50 fc 06 1e 50 55 57 56 52 51 53 ba 7b 00 00 00 8e da 8e
 
