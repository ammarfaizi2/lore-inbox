Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160246AbQHAQph>; Tue, 1 Aug 2000 12:45:37 -0400
Received: by vger.rutgers.edu id <S160160AbQHAQoM>; Tue, 1 Aug 2000 12:44:12 -0400
Received: from [209.10.217.66] ([209.10.217.66]:3914 "EHLO neon-gw.transmeta.com") by vger.rutgers.edu with ESMTP id <S160283AbQHAQnF>; Tue, 1 Aug 2000 12:43:05 -0400
To: linux-kernel@vger.rutgers.edu
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RLIM_INFINITY inconsistency between archs
Date: 1 Aug 2000 10:03:16 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8m6vsk$er6$1@cesium.transmeta.com>
References: <7iw6kYsXw-B@khms.westfalen.de> <8m4uri$d9e$1@enterprise.cistron.net> <8m54u3$dh0$1@cesium.transmeta.com> <8m65np$mm3$1@enterprise.cistron.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: owner-linux-kernel@vger.rutgers.edu

Followup to:  <8m65np$mm3$1@enterprise.cistron.net>
By author:    miquels@cistron.nl (Miquel van Smoorenburg)
In newsgroup: linux.dev.kernel
> 
> Why? As I said you can use a glue layer. Note that you still
> cannot mix /usr/include/net and /usr/src/linux/include/net anyway,
> so clashes will always exist with the current system.
> I agree it should probably be fixed.
> 

A GLUE LAYER IS FREQUENTLY NOT AN OPTION, because you have no data
types to carry around the semantic contents in.  You really *DO* need
to mix both types.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
