Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268095AbTCFN2a>; Thu, 6 Mar 2003 08:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268097AbTCFN2a>; Thu, 6 Mar 2003 08:28:30 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:28933 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S268095AbTCFN23>; Thu, 6 Mar 2003 08:28:29 -0500
Date: Fri, 7 Mar 2003 00:38:29 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: CaT <cat@zip.com.au>
cc: pekkas@netcore.fi, <pavel@suse.cz>, <pavel@ucw.cz>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64 - ipv6/sleep related oops?
In-Reply-To: <20030306131948.GB464@zip.com.au>
Message-ID: <Pine.LNX.4.44.0303070037360.2521-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003, CaT wrote:

> Just looked through dmesg and noticed the following:

> Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
> Call Trace:
>  [<c011f8e8>] __might_sleep+0x54/0x5c
>  [<c0220a91>] crypto_alg_lookup+0x21/0xd0
>  [<c02218e9>] crypto_alg_mod_lookup+0xd/0x34
>  [<c0220c5d>] crypto_alloc_tfm+0x11/0xc0
>  [<c0404cf0>] __ipv6_regen_rndid+0xa0/0x1f4
>  [<c011cd1d>] wake_up_process+0xd/0x14
>  [<c0404e72>] ipv6_regen_rndid+0x2e/0xc4

[...]

Known issue, check recent archives.


- James
-- 
James Morris
<jmorris@intercode.com.au>


