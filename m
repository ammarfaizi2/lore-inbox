Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129164AbQKDCeZ>; Fri, 3 Nov 2000 21:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131116AbQKDCeR>; Fri, 3 Nov 2000 21:34:17 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:52242 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129164AbQKDCdx>; Fri, 3 Nov 2000 21:33:53 -0500
Date: Fri, 3 Nov 2000 20:33:36 -0600
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: asm/resource.h
Message-ID: <20001103203336.L1041@wire.cadcamlab.org>
In-Reply-To: <3A032C1D.D50C8D46@transmeta.com> <3A032E4E.A08DC0EB@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A032E4E.A08DC0EB@timpanogas.org>; from jmerkey@timpanogas.org on Fri, Nov 03, 2000 at 02:29:50PM -0700
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jeff Merkey]
> Is this what is causing the lockup problems on 2.4.0-pre-10 with
> PPro, or something else.  Looks like something else.

Yeah, it does, doesn't it.  If this particular patch cured a
kernel-side lockup I would be very surprised.  Because the only effect
this patch is *supposed* to have is the visibility of certain kernel
header code when compiling userspace programs.

HPA, for what it's worth, which isn't much, I think your patch is
spot-on..

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
