Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbTILRQU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 13:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTILRQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 13:16:20 -0400
Received: from e450.rm.cnr.it ([150.146.1.17]:33759 "EHLO e450.rm.cnr.it")
	by vger.kernel.org with ESMTP id S261768AbTILRQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 13:16:18 -0400
Date: Fri, 12 Sep 2003 19:25:15 +0200
From: flavio <flavio.l@tiscali.it>
Subject: Re: PROBLEM:SCSI repeatable 2.4.22 bug
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <3F62017B.8050503@tiscali.it>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
 Netscape/7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to mention in the previous email that log/messages also shows:
(2.4.22 with dma off and scsi verbose logging)
Sep 11 19:28:13 gundam kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Sep 11 19:28:13 gundam kernel:  printing eip:
Sep 11 19:28:13 gundam kernel: 00000000
Sep 11 19:28:13 gundam kernel: *pde = 00000000
Sep 11 19:28:13 gundam kernel: Oops: 0000
Sep 11 19:28:13 gundam kernel: CPU:	0
Sep 11 19:28:13 gundam kernel: EIP:	0010:[<00000000>]    Not tainted
Sep 11 19:28:13 gundam kernel: EFLAGS: 00210202
Sep 11 19:28:13 gundam kernel: eax: c03cd114   ebx: c03cd1c4   ecx:
00000000   edx: 00000170
Sep 11 19:28:13 gundam kernel: esi: c8c47380   edi: cf393100   ebp:
c922dbb4   esp: c922db8c
Sep 11 19:28:13 gundam kernel: ds: 0018   es: 0018   ss: 0018
Sep 11 19:28:13 gundam kernel: Process nautilus (pid: 1736,
stackpage=c922d000)
Sep 11 19:28:13 gundam kernel: Stack: d092ead4 c03cd1c4 c8c47380
0000000c 00000000 00000003 cf393100 c03cd1c4
Sep 11 19:28:13 gundam kernel:        00000000 00000000 c922dbe8
c02286a2 c03cd1c4 c8c47380 00000000 00000088
Sep 11 19:28:13 gundam kernel:        00000003 c03cd1c4 00000000
00200002 c03cd1c4 cff30580 cafadf80 c922dc0c
Sep 11 19:28:13 gundam kernel: Call Trace:	[<d092ead4>] [<c02286a2>]
[<c0228825>] [<c0228f5f>] [<d092f7b4>]
Sep 11 19:28:13 gundam kernel:   [<d0915785>] [<d091c780>] [<d091c4f0>]
[<d091e338>] [<d091d725>] [<d091d7b9>]
Sep 11 19:28:13 gundam kernel:   [<d0915a8a>] [<c011763c>] [<d0915a8a>]
[<d09150b0>] [<d0915965>] [<d09150b0>]
Sep 11 19:28:13 gundam kernel:   [<d0985b35>] [<d0986dab>] [<d09841d5>]
[<c023663e>] [<d09878a0>] [<c02366b2>]
Sep 11 19:28:13 gundam kernel:   [<c01419ca>] [<c0145c13>] [<d0984a18>]
[<c0235c27>] [<c0141be1>] [<c0141cb7>]
Sep 11 19:28:13 gundam kernel:   [<c01885f6>] [<c0145f3a>] [<c013a251>]
[<c013a176>] [<c01451c3>] [<c013a521>]
Sep 11 19:28:13 gundam kernel:   [<c010743f>]
Sep 11 19:28:13 gundam kernel:
Sep 11 19:28:13 gundam kernel: Code:  Bad EIP value.
Sep 11 19:28:34 gundam su(pam_unix)[1773]: session opened for user root
by (uid=501)
Sep 12 11:52:42 gundam syslogd 1.4.1: restart.






