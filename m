Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135654AbRD1V2h>; Sat, 28 Apr 2001 17:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135653AbRD1V1E>; Sat, 28 Apr 2001 17:27:04 -0400
Received: from 13dyn184.delft.casema.net ([212.64.76.184]:59150 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S131588AbRD1VZZ>; Sat, 28 Apr 2001 17:25:25 -0400
Message-Id: <200104282125.XAA05744@cave.bitwizard.nl>
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <Pine.LNX.4.33.0104281111470.15628-100000@dlang.diginsite.com> from
 David Lang at "Apr 28, 2001 11:21:26 am"
To: David Lang <david.lang@digitalinsight.com>
Date: Sat, 28 Apr 2001 23:25:19 +0200 (MEST)
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

David Lang wrote:
> at the low end useing a bit of disk for swap doesn't hurt, I ran into a
> case a couple years ago on AIX systems. we buy them with 2G ram so that we
> don't need to swap, but discovered (the hard way) that we also needed to
> allocate 4G of disk space for those boxes (allocating less then 2G meant
> that we couldn't use the 2G of RAM). This meant that we had to go out and
> buy 2nd hard drives for every machine, just to put the swap files on.
> 
> now disks are larger today so it's not as much of an issue, but even with
> modern 9-18G drives you can end up eating up 20% or more on a large
> machine, this starts to be significant. you can try to say that any box
> with that much ram must have lots of disk as well, and most of the time
> you will be right, but not all the time. there are cases (webservers for
> example) where the machines will be built with lots of RAM and CPU and
> little disk becouse they get all their content and put all their logs
> elsewhere on the network. in fact with the advances in flash size and the
> desire to create high performance clusters, I would not be surprised to
> see web node machines produced with no hard drives. it means one less
> thing that can break on the system (think a rack of transmeta powered
> boxes with no moving parts in the rack except possibly fans)

On Sat, 28 Apr 2001 R.E.Wolff@BitWizard.nl wrote:

> > I've ALWAYS said that it's a rule-of-thumb. This means that if you
> > have a good argument to do it differently, you should surely do so!

Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
