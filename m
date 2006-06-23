Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751762AbWFWQmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbWFWQmI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 12:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbWFWQmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 12:42:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:21915 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751762AbWFWQmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 12:42:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=hyc0flnm6KydK7cm2MtW+7FaDnBTXWm3bfsZdoVd+Qk48ROwiZ3+Qzj4cjgtokaqA2FxTFZG7CpCIJwNKGG8VJGMaHoSEcoibcdoB4AozLA0vnyST6ZNxSrZ0Hm5q9aJNaBEnRziG5/5KiClqG0Gicf1FR4pjV4kPZagUiSZx7M=
Message-ID: <449C19D3.8050804@gmail.com>
Date: Fri, 23 Jun 2006 18:41:32 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Eduard Bloch <edi@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060623154858.GA15327@rotes76.wohnheim.uni-kl.de>
In-Reply-To: <20060623154858.GA15327@rotes76.wohnheim.uni-kl.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduard Bloch napsal(a):
> #include <hallo.h>
> * Andrew Morton [Wed, Jun 21 2006, 03:48:57AM]:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/
> 
> Cannot build it. Looks like the build system is looping over:
> 
>   GEN     usr/klibc/syscalls/typesize.c
>   KLIBCCC usr/klibc/syscalls/typesize.o
>   OBJCOPY usr/klibc/syscalls/typesize.bin
>   GEN     usr/klibc/syscalls/syscalls.mk
>   GEN     usr/klibc/syscalls/typesize.c
>   KLIBCCC usr/klibc/syscalls/typesize.o
>   OBJCOPY usr/klibc/syscalls/typesize.bin
>   GEN     usr/klibc/syscalls/syscalls.mk
>   GEN     usr/klibc/syscalls/typesize.c
>   KLIBCCC usr/klibc/syscalls/typesize.o
>   OBJCOPY usr/klibc/syscalls/typesize.bin
>   GEN     usr/klibc/syscalls/syscalls.mk
>   GEN     usr/klibc/syscalls/typesize.c
>   KLIBCCC usr/klibc/syscalls/typesize.o
>   OBJCOPY usr/klibc/syscalls/typesize.bin
>   GEN     usr/klibc/syscalls/syscalls.mk
> 
> No matter whether executed as user or as root. Setting KBUILD_VERBOSE
> does not help much, for the log see http://people.debian.org/~blade/log .

Should be fixed already:
http://marc.theaimsgroup.com/?l=linux-kernel&m=115091547426482&w=2

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
