Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132533AbRDKIhM>; Wed, 11 Apr 2001 04:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132536AbRDKIhC>; Wed, 11 Apr 2001 04:37:02 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:52999 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132533AbRDKIgp>; Wed, 11 Apr 2001 04:36:45 -0400
X-Apparently-From: <sedgewick?de@yahoo.de>
Message-ID: <3AD425E0.699E5BA7@yahoo.de>
Date: Wed, 11 Apr 2001 11:37:36 +0200
From: Markus =?iso-8859-1?Q?M=FCller?= <sedgewick_de@yahoo.de>
Organization: IBM Deutschland
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.4-pre1 bug
Content-Type: multipart/mixed;
 boundary="------------F8D877DA6A67476345D82B0C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F8D877DA6A67476345D82B0C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi

I hope I'm not the n-th person reporting this bug. Dump output and a
short description are attached.

kind regards

Markus
--------------F8D877DA6A67476345D82B0C
Content-Type: text/plain; charset=us-ascii;
 name="kernel.bug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel.bug"

Setup Kernel 2.4.4-pre1, SuSE 7.1

Happened during the startup phase when trying to automount
==========================================================================
Apr 11 11:02:36 mmuelle2 kernel: Unable to handle kernel paging request at virtual address 8df9a515
Apr 11 11:02:36 mmuelle2 kernel:  printing eip:
Apr 11 11:02:36 mmuelle2 kernel: c013c7ac
Apr 11 11:02:36 mmuelle2 kernel: *pde = 00000000
Apr 11 11:02:36 mmuelle2 kernel: Oops: 0000
Apr 11 11:02:36 mmuelle2 kernel: CPU:    0
Apr 11 11:02:36 mmuelle2 kernel: EIP:    0010:[__d_path+188/292]
Apr 11 11:02:36 mmuelle2 kernel: EFLAGS: 00010283
Apr 11 11:02:36 mmuelle2 kernel: eax: cda0b860   ebx: 00000fff   ecx: cbebe141
 edx: 8df9a509
Apr 11 11:02:36 mmuelle2 kernel: esi: cda54420   edi: cce73960   ebp: cbebdffe
 esp: cc30deec
Apr 11 11:02:36 mmuelle2 kernel: ds: 0018   es: 0018   ss: 0018
Apr 11 11:02:36 mmuelle2 kernel: Process cat (pid: 706, stackpage=cc30d000)
Apr 11 11:02:36 mmuelle2 kernel: Stack: 00000146 cda54420 cda0b6e0 cda0b6e0 cbebdfff c02545ac c012f232 8df9a509
Apr 11 11:02:37 mmuelle2 kernel:        cda0b860 cda54420 cda0b6e0 cbebd000 00001000 cc30df94 00000c00 cbebe000
Apr 11 11:02:37 mmuelle2 kernel:        00000000 cbebdff7 cda542a0 cce73960 cbebd000 00000146 cce7399c c0147932
Apr 11 11:02:37 mmuelle2 kernel: Call Trace: [sprintf+20/24] [get_filesystem_info+230/1028] [mounts_read_proc+26/52] [proc_file_read+204/420] [sys_read+150/204] [system_call+51/64]
Apr 11 11:02:37 mmuelle2 kernel:
Apr 11 11:02:37 mmuelle2 kernel: Code: 8b 72 0c 89 74 24 14 39 f2 75 19 8b 7c 24 20 8b 47 08 39 f8


--------------F8D877DA6A67476345D82B0C--


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

