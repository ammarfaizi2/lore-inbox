Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131451AbQKJWYf>; Fri, 10 Nov 2000 17:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131488AbQKJWYY>; Fri, 10 Nov 2000 17:24:24 -0500
Received: from 13dyn58.delft.casema.net ([212.64.76.58]:30733 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S131451AbQKJWYK>; Fri, 10 Nov 2000 17:24:10 -0500
Message-Id: <200011102223.XAA04330@cave.bitwizard.nl>
Subject: Re: rdtsc to mili secs?
In-Reply-To: <8uhps8$1tm$1@cesium.transmeta.com> from "H. Peter Anvin" at "Nov
 10, 2000 01:38:16 pm"
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Fri, 10 Nov 2000 23:23:48 +0100 (MET)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Followup to:  <20001110154254.A33@bug.ucw.cz>
> By author:    Pavel Machek <pavel@suse.cz>
> In newsgroup: linux.dev.kernel
> > > 
> > > Sensibly configured power saving/speed throttle systems do not change the
> > > frequency at all. The duty cycle is changed and this controls the cpu 
> > > performance but the tsc is constant
> > 
> > Do you have an example of notebook that does powersaving like that?
> > I have 2 examples of notebooks with changing TSC speed...
> > 
> 
> Intel PIIX-based systems will do duty-cycle throttling, for example.

What's this "duty cycle throtteling"? Some people seem to think this
refers to changing the duty cycle on the clock, and thereby saving
power. I think it doesn't save any power if you do it that way. You
are referring to the duty cycle on a "stpclk" signal, right?


			Roger. 

> However, there are definitely notebooks that will mess with the
> frequency.  At Transmeta, we went through some considerable pain to
> make sure RDTSC would count walltime even across Longrun transitions.


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
*       Common sense is the collection of                                *
******  prejudices acquired by age eighteen.   -- Albert Einstein ********
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
