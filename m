Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129874AbRAYW1K>; Thu, 25 Jan 2001 17:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130282AbRAYW1A>; Thu, 25 Jan 2001 17:27:00 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:53516 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129874AbRAYW0v>; Thu, 25 Jan 2001 17:26:51 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux Post codes during runtime, possibly OT
Date: 25 Jan 2001 14:26:36 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <94q96s$9b2$1@cesium.transmeta.com>
In-Reply-To: <3A709E99.25ADE5F6@echostar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3A709E99.25ADE5F6@echostar.com>
By author:    "Ian S. Nelson" <ian.nelson@echostar.com>
In newsgroup: linux.dev.kernel
>
> I'm curious.  Why does Linux make that friendly 98/9a/88 looking
> postcode pattern when it's running?  DOS and DOS95 don't do that.
> 
> I'm begining to feel like I can tell the system health by observing it,
> kind of like "seeing the matrix."
> 

It output garbage to the 80h port in order to enforce I/O delays.
It's one of the safe ports to issue outs to.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
