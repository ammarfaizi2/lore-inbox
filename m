Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129466AbQKNPR4>; Tue, 14 Nov 2000 10:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130187AbQKNPRh>; Tue, 14 Nov 2000 10:17:37 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:22364
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129466AbQKNPR0>; Tue, 14 Nov 2000 10:17:26 -0500
Date: Tue, 14 Nov 2000 16:44:47 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: oops in 2.2.17, not in 2.2.14-5
Message-ID: <20001114164447.A4286@jaquet.dk>
In-Reply-To: <20001113180449.A652@jaquet.dk> <20001114135924.A3649@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001114135924.A3649@jaquet.dk>; from rasmus@jaquet.dk on Tue, Nov 14, 2000 at 01:59:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> OK, I tried with 2.2.16 and 2.2.18pre21 compiled with egcs-2.91.66
> (the kernels reported yesterday were compiled with 2.95.2).
> 
> 2.2.16 oopsed faithfully (I could not get hold of the oops as several
> scrolled by and none made it to the log). 2.2.18pre21 does not oops.
> Bzip2 core dumps, but gzip makes it through. So it seems that my
> problem has been solved already and proactively :)
> 

Eeek. Apparently I was a bit too early with the champagne... I was
away for an hour or so and when I came back it (2.2.18pre21) had 
oopsed with multiple oops (i.e. the first offscreen) and hardlocked.
I'm now running 2.2.14-5 again, doing the exact same stuff and it
seems to hold up... (knock wood).

Barring someine suggestin a better solution I'll try to compile 
a kernel with serial console and capture an oops that way.

Regards
  Rasmus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
