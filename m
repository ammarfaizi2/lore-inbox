Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbTLCLRb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 06:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTLCLRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 06:17:31 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:9738 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S264542AbTLCLR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 06:17:29 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: tconnors+linuxkernel031203@astro.swin.edu.au (Tim Connors),
       linux-kernel@vger.kernel.org
Subject: Re: Alsa oops, 2.6.0-test8
Organization: Core
In-Reply-To: <Pine.LNX.4.53.0312032050320.10546@tellurium.ssi.swin.edu.au>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.2-20031002 ("Berneray") (UNIX) (Linux/2.4.22-1-686-smp (i686))
Message-Id: <E1ARV0L-0000SV-00@gondolin.me.apana.org.au>
Date: Wed, 03 Dec 2003 22:17:13 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Connors <tconnors+linuxkernel031203@astro.swin.edu.au> wrote:
>
> Nov 25 23:32:46 bohr kernel: Call Trace:
> Nov 25 23:32:46 bohr kernel:  [__crc_generic_file_aio_write+944957/1760761] resample_expand+0x259/0x320 [snd_pcm_oss]

This is a known gcc 3.3 bug triggered by ALSA.

Either use gcc 2.95/3.2 or enable CONFIG_FRAME_POINTER.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
