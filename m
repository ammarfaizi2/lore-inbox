Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264873AbUFLQoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264873AbUFLQoI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 12:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264874AbUFLQoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 12:44:08 -0400
Received: from quechua.inka.de ([193.197.184.2]:10905 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264873AbUFLQoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 12:44:04 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_NOATIME support
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20040612011129.GD1967@flower.home.cesarb.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BZBbt-0007jL-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sat, 12 Jun 2004 18:44:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040612011129.GD1967@flower.home.cesarb.net> you wrote:
> +++ linux-2.6.6/include/asm-arm/fcntl.h 2004-06-10 18:36:55.000000000 -0300
> +#define O_NOATIME      01000000
> +++ linux-2.6.6/include/asm-arm26/fcntl.h       2004-06-10 18:37:42.000000000 -0300
> +#define O_NOATIME      01000000
> +++ linux-2.6.6/include/asm-cris/fcntl.h        2004-06-10 18:37:59.000000000 -0300
> +#define O_NOATIME      01000000
> +++ linux-2.6.6/include/asm-h8300/fcntl.h       2004-06-10 18:38:16.000000000 -0300
> +#define O_NOATIME      01000000
> +++ linux-2.6.6/include/asm-i386/fcntl.h        2004-06-10 18:38:26.000000000 -0300
> +#define O_NOATIME      01000000
> +++ linux-2.6.6/include/asm-ia64/fcntl.h        2004-06-10 18:38:38.000000000 -0300
> +#define O_NOATIME      01000000
> +++ linux-2.6.6/include/asm-m68k/fcntl.h        2004-06-10 18:38:49.000000000 -0300
> +#define O_NOATIME      01000000
> +++ linux-2.6.6/include/asm-mips/fcntl.h        2004-06-10 18:39:12.000000000 -0300
> +#define O_NOATIME      0x40000
> +++ linux-2.6.6/include/asm-parisc/fcntl.h      2004-06-10 18:40:03.000000000 -0300
> +#define O_NOATIME      04000000
> +++ linux-2.6.6/include/asm-ppc/fcntl.h 2004-06-10 18:40:14.000000000 -0300
> +#define O_NOATIME      01000000
> +++ linux-2.6.6/include/asm-ppc64/fcntl.h       2004-06-10 18:40:25.000000000 -0300
> +#define O_NOATIME      01000000
> +++ linux-2.6.6/include/asm-s390/fcntl.h        2004-06-10 18:40:42.000000000 -0300
> +#define O_NOATIME      01000000
> +++ linux-2.6.6/include/asm-sh/fcntl.h  2004-06-10 18:40:52.000000000 -0300
> +#define O_NOATIME      01000000
> +++ linux-2.6.6/include/asm-sparc/fcntl.h       2004-06-10 18:41:14.000000000 -0300
> +#define O_NOATIME      0x200000
> +++ linux-2.6.6/include/asm-sparc64/fcntl.h     2004-06-10 18:41:27.000000000 -0300
> +#define O_NOATIME      0x200000
> +++ linux-2.6.6/include/asm-v850/fcntl.h        2004-06-10 18:41:56.000000000 -0300
> +#define O_NOATIME      01000000
> +++ linux-2.6.6/include/asm-x86_64/fcntl.h      2004-06-10 18:42:13.000000000 -0300
> +#define O_NOATIME      01000000

This is less related  to  your  patch (i like this feature!) but more to the
current source layout: is there a reason for not sharing those open flags on
an non architecture specific file?

And should you not try  to use the same value on all architectures to make
that especially easy to change later?

Greetings
Bernd


-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
