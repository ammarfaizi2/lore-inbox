Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289239AbSBZXpA>; Tue, 26 Feb 2002 18:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289026AbSBZXon>; Tue, 26 Feb 2002 18:44:43 -0500
Received: from tassadar.physics.auth.gr ([155.207.123.25]:51352 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S289298AbSBZXnn>; Tue, 26 Feb 2002 18:43:43 -0500
Date: Wed, 27 Feb 2002 01:43:35 +0200 (EET)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: assertion failure : ext3 & lvm , 2.4.17 smp & 2.4.18-ac1 smp
In-Reply-To: <3C7C1A88.AA6CE5DD@zip.com.au>
Message-ID: <Pine.LNX.4.44.0202270141090.11106-100000@tassadar.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Andrew Morton wrote:

> Dimitris Zilaskos wrote:
> >
> > Assertion failure in do_get_write_access() at transaction.c:730: "(((jh2bh(jh))->b_state & (1UL << BH_Uptodate)) != 0)"
>
> This was fixed in the ext3 patch which went into 2.4.18-pre5

well i just got another one

Assertion failure in do_get_write_access() at transaction.c:730:
"(((jh2bh(jh))->b_state & (1UL << BH_Uptodate)) != 0)"
invalid operand: 0000
CPU:    1
EIP:    0010:[<c016297a>]    Not tainted
EFLAGS: 00010286
eax: 0000007b   ebx: d44ffa94   ecx: 00000097   edx: 00000001
esi: cf514de0   edi: d44ffa00   ebp: c49f8f10   esp: d1bebcd4
ds: 0018   es: 0018   ss: 0018
Process wget (pid: 11038, stackpage=d1beb000)
Stack: c0288aa0 c0288eae c0288a80 000002da c0289060 d44ffa00 cf514de0
c49f8f10
       d44ffa94 00000001 00000001 00000000 00000000 dbd3b660 c0162a3d
cf514de0
       c49f8f10 00000000 00000000 00001076 d7272400 d1bebd8c c0157e00
cf514de0
Call Trace: [<c0162a3d>] [<c0157e00>] [<c023de59>] [<c0159b46>]
[<c0159e1f>]
   [<c015a47e>] [<c021e98e>] [<c015a5c6>] [<c01380eb>] [<c013891e>]
[<c015a56c>]
   [<c015aa6d>] [<c015a56c>] [<c01299b0>] [<c015874a>] [<c0135747>]
[<c0106e7b>]

Code: 0f 0b 83 c4 14 90 8b 4d 00 8b 41 38 0f b6 50 25 8b 7d 0c 8b

uname -an :
Linux test 2.4.18-ac1 #2 SMP Tue Feb 26 23:13:44 EET 2002 i686 unknown

Kind regards ,

--
=============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle Univercity of Thessaloniki , Greece
=============================================================================

