Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269052AbRHFWHR>; Mon, 6 Aug 2001 18:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269053AbRHFWG6>; Mon, 6 Aug 2001 18:06:58 -0400
Received: from [63.209.4.196] ([63.209.4.196]:39953 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269052AbRHFWGt>; Mon, 6 Aug 2001 18:06:49 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: getty problems
Date: 6 Aug 2001 15:06:12 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9kn4ck$ovb$1@cesium.transmeta.com>
In-Reply-To: <20010806142703.A25428@lech.pse.pl> <20010806154530.A26776@lech.pse.pl> <20010807020944.A24146@weta.f00f.org> <20010806182414.A29605@lech.pse.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010806182414.A29605@lech.pse.pl>
By author:    Lech Szychowski <lech.szychowski@pse.pl>
In newsgroup: linux.dev.kernel
>
> >     2.4.7-ac7:
> >     ----------
> [snip]
> > 
> > Are you use this kernel isn't devfs inflicted?
> 
> 2.4.7-ac7 is compiled without devfs, 2.4.5 has devfs support
> compiled in but - IMHO - not used:
> 

Yes, this is a known pathology of devfs.  It will do this to you even
if it isn't used.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
