Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315091AbSFIUUY>; Sun, 9 Jun 2002 16:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSFIUUX>; Sun, 9 Jun 2002 16:20:23 -0400
Received: from p50887457.dip.t-dialin.net ([80.136.116.87]:33717 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315091AbSFIUUW>; Sun, 9 Jun 2002 16:20:22 -0400
Date: Sun, 9 Jun 2002 14:19:46 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: David Woodhouse <dwmw2@infradead.org>
cc: Thunder from the hill <thunder@ngforever.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dave Jones <davej@suse.de>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        <linux-kernel@vger.kernel.org>, <chaffee@cs.berkeley.edu>
Subject: Re: [patch] fat/msdos/vfat crud removal 
In-Reply-To: <2166.1023650940@redhat.com>
Message-ID: <Pine.LNX.4.44.0206091417250.8715-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Jun 2002, David Woodhouse wrote:
> Er, no. If you randomly reassign errno values, the world breaks.
> Don't even contemplate it.

I meant adding. Not just errno, even PF_..., etc.

> To that end, we should put '#ifndef __KERNEL__ #error' into all kernel
> headers, and C libraries should maintain a _separate_ set of headers which
> contain only the ABI definitions and are suitable for userspace. I believe 
> dietlibc already does this, and recent Red Hat distributions contain a 
> 'glibc-kernheaders' package with a slightly-sanitised version of kernel 
> headers, which should become more sanitised over time.

I wouldn't call dietlibc an HighEnd open end API.

Regards,
Thunder
--
German attitude becoming        |       Thunder from the hill at ngforever 
rightaway popular:              |
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere

