Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbTLXNZm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 08:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTLXNZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 08:25:41 -0500
Received: from [62.29.72.87] ([62.29.72.87]:52096 "EHLO southpark.com")
	by vger.kernel.org with ESMTP id S263618AbTLXNZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 08:25:40 -0500
From: "ismail 'cartman' =?Iso-8859-1?q?d=F6nmez?=" 
	<ismail.donmez@boun.edu.tr>
Reply-To: ismail.donmez@boun.edu.tr
Organization: Bogazici University
To: linux-kernel@vger.kernel.org
Subject: Re: PPP ooopses on 2.6.0-mm1 (and 2.6.0, but VMware loaded here)
Date: Wed, 24 Dec 2003 15:25:43 +0200
User-Agent: KMail/1.5.94
References: <200312241121.56934.kde@myrealbox.com> <20031224123415.GA8701@localhost>
In-Reply-To: <20031224123415.GA8701@localhost>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="Iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312241525.43404.ismail.donmez@boun.edu.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 December 2003 14:34, Jose Luis Domingo Lopez wrote:
> Hmmm, I have just had two nasty problems with X the last two days. The
> first went unnoticed in the logs, but yesterday I got the following in
> the logs. It seems strange to me to get an oops with mixed information
> from XFree86 al PPP support.
>
> *BIG FAT WARNING*, VMware modules were loaded, so take the following with a
> BIG grain of salt:
> Dec 24 00:11:23 dardhal kernel: Unable to handle kernel paging request at
> virtual address 10076de4 Dec 24 00:11:23 dardhal kernel: printing eip:
> Dec 24 00:11:23 dardhal kernel: 10076de4
> Dec 24 00:11:23 dardhal kernel: *pde = 00000000
> Dec 24 00:11:23 dardhal kernel: Oops: 0000 [#1]
> Dec 24 00:11:23 dardhal kernel: CPU:    0
> Dec 24 00:11:23 dardhal kernel: EIP:    0060:[<10076de4>]    Tainted: P
> Dec 24 00:11:23 dardhal kernel: EFLAGS: 00013282
> Dec 24 00:11:23 dardhal kernel: EIP is at 0x10076de4
> Dec 24 00:11:23 dardhal kernel: eax: 00000000   ebx: c036d480   ecx:
> da8928c0   edx: da5b7b40 Dec 24 00:11:23 dardhal kernel: esi: 00000200  
> edi: 00000009   ebp: 00000009   esp: dd103ecc Dec 24 00:11:23 dardhal
> kernel: ds: 007b   es: 007b   ss: 0068
> Dec 24 00:11:23 dardhal kernel: Process XFree86 (pid: 895,
> threadinfo=dd102000 task=dcb30cc0) Dec 24 00:11:23 dardhal kernel: Stack:
> c023e919 da8928c0 da5b7b40 00000000 da8928c0 c015d6ca da8928c0 00000000 Dec
> 24 00:11:23 dardhal kernel: dd102000 00000000 00000000 00000000 00000145
> cfffff9a 00000000 42000000 Dec 24 00:11:23 dardhal kernel: cfffff9a
> dd102000 de9967c4 de9967a4 de996784 de996820 de996800 de9967e0 Dec 24
> 00:11:23 dardhal kernel: Call Trace:
> Dec 24 00:11:23 dardhal kernel: [<c023e919>] sock_poll+0x29/0x40
> Dec 24 00:11:23 dardhal kernel: [<c015d6ca>] do_select+0x2aa/0x2b0
> Dec 24 00:11:23 dardhal kernel: [<c015d270>] __pollwait+0x0/0xd0
> Dec 24 00:11:23 dardhal kernel: [<c015d9db>] sys_select+0x2db/0x500
> Dec 24 00:11:23 dardhal kernel: [<c01090cb>] syscall_call+0x7/0xb
> Dec 24 00:11:23 dardhal kernel:
> Dec 24 00:11:23 dardhal kernel: Code:  Bad EIP value.
> Dec 24 00:11:23 dardhal kernel: <7>PPP: VJ decompression error
> Dec 24 00:11:23 dardhal kernel: PPP: VJ decompression error
>


2.6.0 looks fine here.

Regards,
/ismail

-- 
Joe Random Hacker Since 2002
