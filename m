Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUASLoK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 06:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbUASLmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 06:42:32 -0500
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:61958 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S264502AbUASLlq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 06:41:46 -0500
Subject: Re: 2.6.1-mm4
From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20040115225948.6b994a48.akpm@osdl.org>
References: <20040115225948.6b994a48.akpm@osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1074512784.19380.3.camel@telecentrolivre>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 19 Jan 2004 09:46:25 -0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Em Sex, 2004-01-16 às 04:59, Andrew Morton escreveu:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm4/

I got this today, after an '# shutdown -r now':

EFLAGS: 00010082
EIP is at __tasklet_schedule+0x35/0x50
eax: c48d0000   ebx: 00000046   ecx: 0000009d   edx: c7fb99d0
esi: c201b9d0   edi: 00000000   ebp: c48d1ebc   esp: c48d1eb8
ds: 007b   es: 007b   ss: 0068
Process rc (pid: 11596, threadinfo=c48d0000 task=c201b9d0)
Stack: 00000000 c48d1ee8 c0117c34 00000000 00000000 0e5fb9c6 03acf444 27263b42
       0000ea8d c76029d0 c48d0000 00000000 c48d1f00 c011742d 00000000 00000000
       01200011 c76029d0 c48d1f4c c011a81d 00000000 01200011 bffff614 00000000
Call Trace:
 [<c0117c34>] scheduler_tick+0x564/0x580
 [<c011742d>] sched_fork+0x7d/0x80
 [<c011a81d>] copy_process+0x5dd/0x9e0
 [<c011ac6d>] do_fork+0x4d/0x17a
 [<c0125f3d>] sigprocmask+0x4d/0xc0
 [<c0109af5>] sys_clone+0x45/0x50
 [<c0301723>] syscall_call+0x7/0xb

Code: 3a 35 c0 89 10 83 0d 40 51 3f c0 20 a3 14 3a 35 c0 b8 00 e0 ff ff 21 e0 f7
 40 14 00 ff ff 00 75 10 8b 15 60 52 3f c0 85 d2 74 06 <8b> 02 85 c0 75 05 53 9d
 5b 5d c3 89 d0 e8 f9 84 ff ff eb f2 8d

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

