Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317946AbSHPBrE>; Thu, 15 Aug 2002 21:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317950AbSHPBrE>; Thu, 15 Aug 2002 21:47:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36100 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317946AbSHPBrD>; Thu, 15 Aug 2002 21:47:03 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Problem with random.c and PPC
Date: 15 Aug 2002 18:50:32 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ajhlp8$qse$1@cesium.transmeta.com>
References: <200208151514.51462.henrique@cyclades.com> <20020815190336.GN22974@opus.bloom.county> <20020815195933.GW9642@clusterfs.com> <20020815210449.GA26993@opus.bloom.county>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020815210449.GA26993@opus.bloom.county>
By author:    Tom Rini <trini@kernel.crashing.org>
In newsgroup: linux.dev.kernel
> 
> Ah, thanks.  In that case, no.  It doesn't look like the input-layer USB
> keyboards contribute to entropy (but mice do), and I don't think the ADB
> ones do.  I'll take a crack at adding this to keyboards monday maybe.
> 

Be careful... USB devices are *always* going to speak at the same
place in the USB cycle... I believe that is 1 ms.  Thus,
submillisecond resolution is *not* random.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
