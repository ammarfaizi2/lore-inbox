Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131994AbQKSASp>; Sat, 18 Nov 2000 19:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131996AbQKSASg>; Sat, 18 Nov 2000 19:18:36 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:47121 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131994AbQKSAS3>; Sat, 18 Nov 2000 19:18:29 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: rdtsc to mili secs?
Date: 18 Nov 2000 15:48:06 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8v74fm$2d7$1@cesium.transmeta.com>
In-Reply-To: <3A078C65.B3C146EC@mira.net> <20001116115730.A665@suse.cz> <8v1pfj$p5e$1@cesium.transmeta.com> <20001118211349.B382@bug.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001118211349.B382@bug.ucw.cz>
By author:    Pavel Machek <pavel@suse.cz>
In newsgroup: linux.dev.kernel

> > Actually, on machines where RDTSC works correctly, you'd like to use
> > that to detect a lost timer interrupt.
> > 
> > It's tough, it really is :(
> 
> Well, my patch did not do that but you probably want lost timer
> interrupt detection so that you avoid false alarms.
> 
> But that means you can no longer detect speed change after 10msec:
> 
> going from 150MHz to 300MHz is very similar to one lost timer
> interrupt.
> 

That's the point.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
