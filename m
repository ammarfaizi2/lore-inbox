Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270273AbRIBH3i>; Sun, 2 Sep 2001 03:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271588AbRIBH32>; Sun, 2 Sep 2001 03:29:28 -0400
Received: from chmls05.mediaone.net ([24.147.1.143]:46540 "EHLO
	chmls05.mediaone.net") by vger.kernel.org with ESMTP
	id <S270273AbRIBH3P>; Sun, 2 Sep 2001 03:29:15 -0400
Message-ID: <3B91E000.A2E36F6@mediaone.net>
Date: Sun, 02 Sep 2001 03:30:08 -0400
From: Robert La Ferla <robertlaferla@mediaone.net>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Serious system problems with 2.4.9 and 2.4.3 kernels
In-Reply-To: <3B91C998.D669C94F@mediaone.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another kernel message from the other program that zombied.  If
there's anything I can do to help debug this, please let me know.

Robert

Sep  2 00:00:00 localhost kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Sep  2 00:00:00 localhost kernel:  printing eip:
Sep  2 00:00:00 localhost kernel: 00000000
Sep  2 00:00:00 localhost kernel: pgd entry ed116000: 0000000000000000
Sep  2 00:00:00 localhost kernel: pmd entry ed116000: 0000000000000000
Sep  2 00:00:00 localhost kernel: ... pmd not present!
Sep  2 00:00:00 localhost kernel: Oops: 0000
Sep  2 00:00:00 localhost kernel: CPU:    0
Sep  2 00:00:00 localhost kernel: EIP:    0010:[<00000000>]
Sep  2 00:00:00 localhost kernel: EFLAGS: 00010286
Sep  2 00:00:00 localhost kernel: eax: c024af00   ebx: 00000010   ecx:
d63fce00   edx: e6bd4af0
Sep  2 00:00:00 localhost kernel: esi: d63fce00   edi: 00000000   ebp:
00000145   esp: d6babf1c
Sep  2 00:00:00 localhost kernel: ds: 0018   es: 0018   ss: 0018
Sep  2 00:00:00 localhost kernel: Process myapp (pid: 10544,
stackpage=d6bab000)
Sep  2 00:00:00 localhost kernel: Stack: c01b570f d63fce00 e6bd4af0
00000000 c01405e0 d63fce00 00000000 d6babf54
Sep  2 00:00:00 localhost kernel:        01000000 d6baa000 000020ed
00000218 00000000 00000219 00000000 c096d000
Sep  2 00:00:00 localhost kernel:        00000020 563e8b4c d58f1b00
00000400 c0140a69 00000400 d6babf90 d6babf8c
Sep  2 00:00:00 localhost kernel: Call Trace: [sock_poll+31/48]
[do_select+288/576] [sys_select+825/1152] [system_cal
l+51/56]
Sep  2 00:00:00 localhost kernel: Call Trace: [<c01b570f>] [<c01405e0>]
[<c0140a69>] [<c0106d2b>]
Sep  2 00:00:00 localhost kernel:
Sep  2 00:00:00 localhost kernel: Code:  Bad EIP value.


