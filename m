Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUCZOZb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 09:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbUCZOZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 09:25:31 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:8205 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262794AbUCZOZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 09:25:29 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6: improved fdmap
Date: Fri, 26 Mar 2004 15:24:56 +0100
User-Agent: KMail/1.6.1
Cc: Matt Miller <mmiller@hick.org>, viro@parcelfarce.linux.theplanet.co.uk
References: <Pine.LNX.4.58.0403252228420.20049@jethro.hick.org>
In-Reply-To: <Pine.LNX.4.58.0403252228420.20049@jethro.hick.org>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403261524.56694@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 March 2004 05:36, Matt Miller wrote:

Hi Matt,

> diff -X dontdiff -uprN linux-2.6.4/include/asm-s390/unistd.h
> linux-2.6.4-fdmap/include/asm-s390/unistd.h ---
> linux-2.6.4/include/asm-s390/unistd.h	Wed Mar 10 20:55:55 2004 +++
> linux-2.6.4-fdmap/include/asm-s390/unistd.h	Sun Mar 21 04:09:53 2004 @@
> -256,12 +256,13 @@
>  #define __NR_clock_gettime	(__NR_timer_create+6)
>  #define __NR_clock_getres	(__NR_timer_create+7)
>  #define __NR_clock_nanosleep	(__NR_timer_create+8)
> +#define __NR_fdmap		265
>  /*
>   * Number 263 is reserved for vserver
>   */
> -#define __NR_fadvise64_64	264
> +#define __NR_fadvise64_64	265
>
> -#define NR_syscalls 265
> +#define NR_syscalls 266

hmm, fdmap == 265 and fadvise64_64 also 265? I think you can leave 
fadvise64_64 at 264 ;)


ciao, Marc
