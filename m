Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131598AbRABUfQ>; Tue, 2 Jan 2001 15:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131717AbRABUfG>; Tue, 2 Jan 2001 15:35:06 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:28679 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131598AbRABUey>; Tue, 2 Jan 2001 15:34:54 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Coppermine is a PIII or a Celeron? WINCHIP2/WINCHIP3D diff?
Date: 2 Jan 2001 12:04:21 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <92tc85$2v3$1@cesium.transmeta.com>
In-Reply-To: <3A523012.CF78B83D@dplanet.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3A523012.CF78B83D@dplanet.ch>
By author:    "Giacomo A. Catenazzi" <cate@dplanet.ch>
In newsgroup: linux.dev.kernel
> 
> When working in cpu autoconfiguration I found some problems:
> 
> I have to identify this processor:
>   Vendor: Intel
>   Family: 6
>   Model:  8
> Is it a "Pentium III (Coppermine)" (setup.c:1709)
> or a "Celeron (Coppermine)" (setup.c:1650) ?
> 

Line 1650 takes precedence, *IF* the L2$ size is 128K.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
