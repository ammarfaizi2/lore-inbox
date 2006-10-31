Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422888AbWJaLCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422888AbWJaLCO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 06:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423078AbWJaLCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 06:02:14 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:27411 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1422888AbWJaLCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 06:02:14 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Sun Zongjun-E5739C" <E5739C@motorola.com>
Subject: Re: Can't compile linux-2.6.10 on FC5
Date: Tue, 31 Oct 2006 11:02:10 +0000
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <565F40B9893580489B94B8D324460AF4E9FF86@zmy16exm63.ds.mot.com>
In-Reply-To: <565F40B9893580489B94B8D324460AF4E9FF86@zmy16exm63.ds.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610311102.10795.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 October 2006 04:17, Sun Zongjun-E5739C wrote:
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

My guess is that this is fallout from H.J. Lu's binutils changes. I suggest 
searching the internet for the release notes for 2.16.91.0.6, where I think 
patches are referenced for Linux 2.5 that should patch against 2.6.10.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
