Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266122AbUAQUSW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 15:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUAQUSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 15:18:22 -0500
Received: from power.vereya.net ([62.73.72.3]:29278 "HELO power.vereya.net")
	by vger.kernel.org with SMTP id S266122AbUAQUST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 15:18:19 -0500
Message-ID: <010801c3dd37$1ff2ee20$8648493e@ixip.net>
From: "Condor" <condor@vereya.net>
To: "Mike Fedyk" <mfedyk@matchmail.com>
Cc: <linux-kernel@vger.kernel.org>
References: <00e201c3dd32$25bde0d0$8648493e@ixip.net> <20040117195151.GY1748@srv-lnx2600.matchmail.com>
Subject: Re: 2.4.24 may be bug in prints.c:341
Date: Sat, 17 Jan 2004 22:18:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Mike Fedyk" <mfedyk@matchmail.com>
To: "Condor" <condor@vereya.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, January 17, 2004 9:51 PM
Subject: Re: 2.4.24 may be bug in prints.c:341


> On Sat, Jan 17, 2004 at 09:42:46PM +0200, Condor wrote:
> > Hello all,
> >
> > 1. My server stop work after trying to access hard drives.
> > 2. My server have kernel panic when trying to access hard drives. I
don't
> > now what is the real problem,
>
> Did you run fsck on the filesystem?

Yes i run, but problem did'nt resolved. The problem is in hard drive, now
disk is gone and may be every thing
is work fine ...

>
> > Jan 16 01:55:19 heaven kernel: kernel BUG at prints.c:341!
> > Jan 16 01:55:19 heaven kernel: invalid operand: 0000
> > Jan 16 01:55:19 heaven kernel: CPU:    1
> > Jan 16 01:55:19 heaven kernel: EIP:    0010:[<c01a3eb8>]    Not tainted
> > Jan 16 01:55:19 heaven kernel: EFLAGS: 00010286
> > Jan 16 01:55:19 heaven kernel: eax: 0000004a   ebx: eac82800   ecx:
00000000
> > edx: f6febf7c
> > Jan 16 01:55:19 heaven kernel: esi: 00000000   edi: c2849ed4   ebp:
00000002
> > esp: c2849e24
> > Jan 16 01:55:19 heaven kernel: ds: 0018   es: 0018   ss: 0018
> > Jan 16 01:55:19 heaven kernel: Process kupdated (pid: 7,
stackpage=c2849000)
> > Jan 16 01:55:19 heaven kernel: Stack: c0270d4d c0324fc0 c0323560
eac82800
> > c01b33f9 eac82800 c027b9a0 00001295
> > Jan 16 01:55:19 heaven kernel:        00000296 00000001 00000004
eac82800
> > 00000006 c2849ed4 00000000 c01b39e7
> > Jan 16 01:55:19 heaven kernel:        c2849ed4 eac82800 00000001
00000006
> > f899d38c 00000000 00000024 00000004
> > Jan 16 01:55:19 heaven kernel: Call Trace:    [<c01b33f9>] [<c01b39e7>]
> > [<c01b30e7>] [<c01a0c50>] [<c014785c>]
> > Jan 16 01:55:19 heaven kernel:   [<c014684c>] [<c0146c02>] [<c0107652>]
> > [<c0146ac0>] [<c0105000>] [<c01058be>]
> > Jan 16 01:55:19 heaven kernel:   [<c0146ac0>]
> > Jan 16 01:55:19 heaven kernel:
> > Jan 16 01:55:19 heaven kernel: Code: 0f 0b 55 01 60 0d 27 c0 85 db 74 0e
0f
> > b7 43 08 89 04 24 e8
>
> You didn't run it through ksymoops...
> -

-

