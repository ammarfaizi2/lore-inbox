Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130619AbRBLSwQ>; Mon, 12 Feb 2001 13:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130664AbRBLSwI>; Mon, 12 Feb 2001 13:52:08 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:27404 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130619AbRBLSv7>; Mon, 12 Feb 2001 13:51:59 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: LILO and serial speeds over 9600
Date: 12 Feb 2001 10:51:46 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <969bc2$seh$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10102120741290.3761-100000@main.cyclades.com> <Pine.LNX.4.10.10102120849580.3761-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.10.10102120849580.3761-100000@main.cyclades.com>
By author:    Ivan Passos <lists@cyclades.com>
In newsgroup: linux.dev.kernel
> 
> Since I still want to add support for speeds up to 115200, the other two
> questions are still up (see below):
> 

Just checked my own code, and SYSLINUX does indeed support 115200 (I
changed this to be a 32-bit register ages ago, apparently.)  Still
doesn't answer the question "why"... all I think you do is increase
the risk for FIFO overrun and lost characters (flow control on a boot
loader console is vestigial at the best.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
