Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423528AbWJaQEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423528AbWJaQEp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423529AbWJaQEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:04:45 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:13729 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1423528AbWJaQEo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:04:44 -0500
Message-ID: <45477411.9030808@gmail.com>
Date: Tue, 31 Oct 2006 17:04:33 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Sun Zongjun-E5739C <E5739C@motorola.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Can't compile linux-2.6.10 on FC5
References: <565F40B9893580489B94B8D324460AF4E9FF86@zmy16exm63.ds.mot.com>
In-Reply-To: <565F40B9893580489B94B8D324460AF4E9FF86@zmy16exm63.ds.mot.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun Zongjun-E5739C wrote:
> Hi, 
> 
> I prepare to compile linux-2.6.10 on FC5. But it report the following
> errors when compiling the function of show_regs defined
> arch/i386/kernel/process.c
> 
> {standard input}: Assembler messages:
> {standard input}: 797: Error: suffix or operands invalid for 'mov'
> ....
> 
> My GCC is 4.1, binutils is 2.16.91.0.6. It does not work too even after
> I used CC=gcc32 make bzImage
> 
> I have searched it via Google. And found many such problems. How can fix
> it?

Probably by installing older `as'.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
