Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316163AbSFZBPW>; Tue, 25 Jun 2002 21:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316167AbSFZBPV>; Tue, 25 Jun 2002 21:15:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1541 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316163AbSFZBPV>; Tue, 25 Jun 2002 21:15:21 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] 2.5.24: auto_fs.h typo.
Date: 25 Jun 2002 18:15:02 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <afb4im$6nl$1@cesium.transmeta.com>
References: <200206251759.34690.schwidefsky@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200206251759.34690.schwidefsky@de.ibm.com>
By author:    Martin Schwidefsky <schwidefsky@de.ibm.com>
In newsgroup: linux.dev.kernel
>
> Hi Linus,
> my last patch for include/linux/auto_fs.h contained a typo that removed the
> trailing underscores from __x86_64__.
> 
> blue skies,
>   Martin.
> 
> diff -urN linux-2.5.24/include/linux/auto_fs.h linux-2.5.24-s390/include/linux/auto_fs.h
> --- linux-2.5.24/include/linux/auto_fs.h	Fri Jun 21 00:53:40 2002
> +++ linux-2.5.24-s390/include/linux/auto_fs.h	Fri Jun 21 14:46:59 2002
> @@ -45,7 +45,7 @@
>   * If so, 32-bit user-space code should be backwards compatible.
>   */
>  
> -#if defined(__sparc__) || defined(__mips__) || defined(__x86_64) \
> +#if defined(__sparc__) || defined(__mips__) || defined(__x86_64__) \
>   || defined(__powerpc__) || defined(__s390__)
>  typedef unsigned int autofs_wqt_t;
>  #else
> 

Please change this to:

#ifndef __alpha__

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
