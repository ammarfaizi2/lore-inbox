Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130200AbQLMKPp>; Wed, 13 Dec 2000 05:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130461AbQLMKPf>; Wed, 13 Dec 2000 05:15:35 -0500
Received: from 13dyn105.delft.casema.net ([212.64.76.105]:40714 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S130200AbQLMKP0>; Wed, 13 Dec 2000 05:15:26 -0500
Message-Id: <200012130944.KAA30595@cave.bitwizard.nl>
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
In-Reply-To: <E145b60-00007M-00@the-village.bc.nu> from Alan Cox at "Dec 11,
 2000 10:06:54 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 13 Dec 2000 10:44:38 +0100 (MET)
CC: Gerhard Mack <gmack@innerfire.net>, Rik van Riel <riel@conectiva.com.br>,
        John Fremlin <vii@penguinpowered.com>, scole@lanl.gov,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > How much of that is due to the fact that the 2.4.0 scheduler interrupts
> > processes more often than 2.2.x?  Is the better interactivity worth the
> > slight drop in performance?
> 
> What better interactivity ;)

Indeed!

On my dual Celeron workstation, 2.4 looks to me as if it is scheduling
"more". Thus when I move a window, the window takes on all intervening
positions. Under 2.2, the window sometimes jerks 10 pixels or so, but
it acutally follows the mouse. Under 2.4, you can get hte window to
lag the mouse by a significant amount.

Thus to me, 2.4 FEELS much less interactive. When I move windows they
don't follow the mouse in real-time. 

				Roger.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
