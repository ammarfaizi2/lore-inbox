Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbQKHDkS>; Tue, 7 Nov 2000 22:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129414AbQKHDkI>; Tue, 7 Nov 2000 22:40:08 -0500
Received: from [194.73.73.138] ([194.73.73.138]:1749 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S129116AbQKHDjx>;
	Tue, 7 Nov 2000 22:39:53 -0500
From: davej@suse.de
Date: Wed, 8 Nov 2000 03:39:39 +0000 (GMT)
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: David Lang <david.lang@digitalinsight.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Installing kernel 2.4
In-Reply-To: <3A0899EC.BCF17E69@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0011080332330.8632-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Jeff V. Merkey wrote:

> > remember it's not just the start of the file that varies based on cachline
> > size, it's the positioning of code and data thoughout the kernel image.
> Understood.  I will go off and give some thought and study and respond
> later after I have a proposal on the best way to do this.   In NetWare,
> we had indirections in the code all over the place.  NT just make huge
> and fat programs (NTKRNLOS.DLL is absolutely huge).

I'm glad you realise this.  The Netware method you mention above sounds
over complicated for the desired end result, and the NT method just sounds
like a gross hack.

The current 'compile for the arch you intend to run on' is right now,
the simplest, cleanest way to do this.

If you manage to pull something off in MANOS or whatever other OS,
to prove all this otherwise (without resorting to ugly hacks like the
above), great for you, I (and I assume others) would like to hear
about it.

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
