Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135650AbRD1VXv>; Sat, 28 Apr 2001 17:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133022AbRD1VXm>; Sat, 28 Apr 2001 17:23:42 -0400
Received: from 13dyn184.delft.casema.net ([212.64.76.184]:56846 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S135652AbRD1VXY>; Sat, 28 Apr 2001 17:23:24 -0400
Message-Id: <200104282123.XAA05735@cave.bitwizard.nl>
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <200104281804.f3SI4ar368494@saturn.cs.uml.edu> from "Albert D. Cahalan"
 at "Apr 28, 2001 02:04:35 pm"
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Date: Sat, 28 Apr 2001 23:23:15 +0200 (MEST)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Wakko Warner <wakko@animx.eu.org>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:
> So that is a factor of 50 in price. It's what, a factor of 1000000
> in access time?

Actually it's only about 100000. 

> > That disk space is just sitting there. Never to be used. I spent $400
> > on the RAM, and I'm now reserving about $8 worth of disk space for
> > swap. I think that the $8 is well worth it. It keeps my machine
> > functional a while longer should something go haywire... As I said:
> > If you don't want to see it that way: Fine with me. 
> 
> It is a disaster waiting to happen. Instead of having the offending
> process get killed, your machine could suffer extreme thrashing.
> 
> Have enough swap for idle processes and no more.

Right. Now there is some time where "extreme thrashing" will alert ME
(a human, I think) to try and find/kill the offending process.

Otherwise I have to trust Rik's OOM killer. Now his OOM killer isn't
all that bad. But it isn't human. Humans are better at actually
finding the real CAUSE. An OOM killer might hit one or two innocent
processes along the way. So far I've killed the right process ALL the
time. I can't say the same for the OOM killer.

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
