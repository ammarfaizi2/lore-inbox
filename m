Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319002AbSH1VvG>; Wed, 28 Aug 2002 17:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319005AbSH1VvG>; Wed, 28 Aug 2002 17:51:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49422 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319002AbSH1VvG>; Wed, 28 Aug 2002 17:51:06 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Bug in kernel code?
Date: 28 Aug 2002 14:54:59 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <akjgrj$o7m$1@cesium.transmeta.com>
References: <3D6BD62C.581.ACEBAD@localhost> <20020827.203946.102043898.davem@redhat.com> <3D6BEF22.21951.10E69E8@localhost> <20020827.212649.102436426.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020827.212649.102436426.davem@redhat.com>
By author:    "David S. Miller" <davem@redhat.com>
In newsgroup: linux.dev.kernel
>
>    From: "Stephen Biggs" <s.biggs@softier.com>
>    Date: Tue, 27 Aug 2002 21:29:06 -0700
> 
>    You tell me.  You're saying a billion pages (((unsigned long)(~0)) >> 2) also crashes) is never 
>    going to be realistically possible?
> 
> On a 32-bit system?  No.  x86 cpus are architectually limited
> to 64GB of memory, shift that right by PAGE_SIZE (13) and we're
> still within bounds.                   ^^^^^^^^^^^^^^
> 

PAGE_SHIFT, 12.

The maximum possible page count of any known 32-bit system (64 GB @ 4K
for x86) is 2^24 pages.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
