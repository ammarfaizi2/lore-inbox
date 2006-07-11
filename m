Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWGKM14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWGKM14 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWGKM14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:27:56 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:61364 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751245AbWGKM14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:27:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CElv5hhbCVv0xCWssKJOuWLh7m9dZbUeK5uyN56Pl6sE8WsQ6F/3coe2dwFZQ/2Yz+vl2OmE1cP9F8b0hSxmrWoB4k7HKsU4dnNof+CU6Li/Nd7dqUTS88/FsqGpu0dZ024bpKD0H048ZF0GG5NJgbZHGysbE1hu6+aZxh7KUtM=
Message-ID: <6bffcb0e0607110527x4520d5bbne8b9b3639a821a18@mail.gmail.com>
Date: Tue, 11 Jul 2006 14:27:55 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060710220901.5191.66488.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 11/07/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> This is a new version (0.8) of the kernel memory leak detector. See
> the Documentation/kmemleak.txt file for a more detailed
> description. The patches are downloadable from (the whole patch or the
> broken-out series):
>
> http://homepage.ntlworld.com/cmarinas/kmemleak/patch-2.6.18-rc1-kmemleak-0.8.bz2
> http://homepage.ntlworld.com/cmarinas/kmemleak/patches-kmemleak-0.8.tar.bz2
>

Unfortunately, it doesn't compile for me.

make O=/dir
[..]
CC      arch/i386/kernel/alternative.o
{standard input}: Assembler messages:
{standard input}:1954: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:1955: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:1959: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:1960: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:1964: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:1965: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:1972: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:1973: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:1979: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:1980: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:1984: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:1985: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:1989: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:1990: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:1997: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:1998: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:2004: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:2005: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:2009: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:2010: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:2014: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:2015: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:2022: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
{standard input}:2023: Error: can't resolve `.data' {.data section} -
`.Ltext0' {.text section}
make[2]: *** [arch/i386/kernel/alternative.o] Error 1
make[1]: *** [arch/i386/kernel] Error 2
make: *** [_all] Error 2

> --
> Catalin
> -

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
