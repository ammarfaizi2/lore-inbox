Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266586AbTGFB0l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 21:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266587AbTGFB0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 21:26:41 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:48910 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266586AbTGFB0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 21:26:39 -0400
Subject: Re: 2.5.74-mm2 [kernel BUG at include/linux/list.h:148!]
From: =?ISO-8859-1?Q?Ram=F3n?= Rey =?UTF-8?Q?Vicente?=
	 =?UTF-8?Q?=F3=AE=A0=92?= <retes_simbad@yahoo.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030705132528.542ac65e.akpm@osdl.org>
References: <20030705132528.542ac65e.akpm@osdl.org>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1057455650.3119.3.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 06 Jul 2003 03:40:51 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Recently compiled and booted succesfully, I obtain this message

kernel BUG at include/linux/list.h:148!
invalid operand: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c0118599>]    Not tainted VLI
EFLAGS: 00210093
eax: c9d3dd50   ebx: c4418000   ecx: c9d3dd50   edx: c4419dcc
esi: c4419dc0   edi: 00200246   ebp: cf0eda40   esp: c4419d88
ds: 007b   es: 007b   ss: 0068
Process xine (pid: 2691, threadinfo=c4418000 task=c81b66b0)
Stack: c9d3dd50 c4419dc0 c4418000 c0193e05 c9d3dd4c c12d3b60 00000000
c81b66b0 
       c0116f20 00000000 00000000 00200082 c0116fbc caec34d8 00000000
c81b66b0 
       c0116f20 c9d3dd50 c9d3dd50 c4419efb 124641e5 00000005 cf0eda40
c4419e58 
Call Trace: [<c0193e05>]  [<c0116f20>]  [<c0116fbc>]  [<c0116f20>] 
[<c0156924>]  [<c0156dae>]  [<c023e8ea>]  [<c023f062>]  [<c01f2a9a>] 
[<c01f26c7>]  [<c01f346e>]  [<c010a9ef>]  [<c0108f47>] 
Code: 20 00 c7 46 0c 00 01 10 00 57 9d ff 4b 14 8b 43 08 a8 08 75 04 5b
5e 5f c3 5b 5e 5f e9 31 e9 ff ff 0f 0b 95 00 e4 be 24 c0 eb cb <0f> 0b
94 00 e4 be 24 c0 eb b9 90 90 90 90 90 90 90 90 90 90 90 
 <6>note: xine[2691] exited with preempt_count 1
-- 
/================================================\
| Ramón Rey Vicente <ramon.rey at hispalinux.es> |
|                                                |
| Jabber ID <rreylinux at jabber.org>            |
|                                                |
| Public GPG Key http://pgp.escomposlinux.org    |
|                                                |
| GLiSa http://glisa.hispalinux.es               |
\================================================/

