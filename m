Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130208AbRAYXbj>; Thu, 25 Jan 2001 18:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129703AbRAYXb3>; Thu, 25 Jan 2001 18:31:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:32528 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129334AbRAYXbV>; Thu, 25 Jan 2001 18:31:21 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: hotmail not dealing with ECN
Date: 25 Jan 2001 15:31:02 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <94qcvm$9qp$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com>
By author:    Jeremy Hansen <jeremy@xxedgexx.com>
In newsgroup: linux.dev.kernel
>
> Just curious if others have noticed that hotmail is unable to deal with
> ECN and wondering if this is a standard that should be encouraged, as in
> should I tell hotmail that perhaps they should look into supporting it, or
> should I not waste my breath and echo 0 > /proc/sys/net/ipv4/tcp_ecn?
> 

They are.  I do think they have a point, though; ECN is listed as an
experimental standard at IETF, and I do think that it's not exactly
fair to *require* everyone to use it until it is standards-track.  It
would be another thing if Linux could turn it off on a per-connection
basis if these packets get dropped.

In general, I have found the Hotmail people to be quite responsive to
problems as long as they gets pointed out that they violate
established standards.  In this case, though, they feel that they
don't want to potentially destabilize their network over something
that is labelled an experimental standard.  I can certainly understand
their point.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
