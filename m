Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129601AbQK0UXd>; Mon, 27 Nov 2000 15:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129631AbQK0UXX>; Mon, 27 Nov 2000 15:23:23 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:27397 "EHLO saturn.cs.uml.edu")
        by vger.kernel.org with ESMTP id <S129601AbQK0UXH>;
        Mon, 27 Nov 2000 15:23:07 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011271952.eARJqqw514056@saturn.cs.uml.edu>
Subject: Re: KERNEL BUG: console not working in linux
To: hpa@zytor.com (H. Peter Anvin)
Date: Mon, 27 Nov 2000 14:52:52 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8vubeq$r5r$1@cesium.transmeta.com> from "H. Peter Anvin" at Nov 27, 2000 11:08:10 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> [Albert Cahalan]
>> [Alan Cox]

>>>> 1) Why did they disable my videocard ?
>>>
>>> Because your machine is not properly PC compatible
>>
>> The same can be said of systems that don't support the
>> standard keyboard controller for A20 control.
>
> Yes, it can.  Unfortunately, some "legacy-free" PCs apparently
> are starting to take the tack that the KBC is legacy.  Therefore,
> the use of port 92h is mandatory on those systems.

Not just embedded systems?

> Port 92h dates back to at the very least the IBM PS/2.
> 
> Either way, the video card of the original poster is broken in more
> ways than that.  Ports 0x00-0xFF are reserved for the motherboard
> chipset and have been since the original IBM PC.

His video card is the motherboard. He has built-in video.
So the port is being used by his motherboard chipset.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
