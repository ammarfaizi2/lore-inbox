Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316423AbSFDFTS>; Tue, 4 Jun 2002 01:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316459AbSFDFTR>; Tue, 4 Jun 2002 01:19:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32261 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316423AbSFDFTQ>; Tue, 4 Jun 2002 01:19:16 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Algorithm for CPU_X86
Date: 3 Jun 2002 22:19:12 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <adhikg$tcc$1@cesium.transmeta.com>
In-Reply-To: <20020604031840.GA4289@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020604031840.GA4289@werewolf.able.es>
By author:    "J.A. Magallon" <jamagallon@able.es>
In newsgroup: linux.dev.kernel
> 
> Following with the cpu selection changes, setting the flags controlled
> by the various CPU_X86_xxxx can be a real mess.
> 
> But, I have ralized that those CPU_X86 flags can be logically split in
> two groups: features (TSC,MMX,3DNOW) and bugfixes (PPRO_FENCE) (or perhaps
> more, it is just a first thought...).
> 

Don't forget optimizations.  It's a big difference between "optimize
for" and "require" -- consider gcc, which have -mcpu= and -march=
respectively for the two.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
