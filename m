Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283938AbRLFGFM>; Thu, 6 Dec 2001 01:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285001AbRLFGFF>; Thu, 6 Dec 2001 01:05:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9999 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283938AbRLFGEr>; Thu, 6 Dec 2001 01:04:47 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Endianness-aware mkcramfs
Date: 5 Dec 2001 22:04:22 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9un1p6$gcj$1@cesium.transmeta.com>
In-Reply-To: <3C0BD8FD.F9F94BE0@mvista.com> <20011204170235.M25671@mvista.com> <20011204173819.C29968@one-eyed-alien.net> <3C0E11A8.A3057B7D@lightning.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C0E11A8.A3057B7D@lightning.ch>
By author:    Daniel Marmier <daniel.marmier@lightning.ch>
In newsgroup: linux.dev.kernel
> 
> Approved. Byteswapping some metadata fields has a negligible cost.
> I did not post this patch in the hope it would be integrated, but
> because Jeremy needed it.
> 
> If there is consensus about the "always little-endian cramfs" idea,
> let's go for it and please ignore this patch.
> 

It's the only way to do it.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
