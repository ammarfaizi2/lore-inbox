Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263942AbRFHJ0s>; Fri, 8 Jun 2001 05:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263943AbRFHJ0j>; Fri, 8 Jun 2001 05:26:39 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:45461 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S263942AbRFHJ0b>; Fri, 8 Jun 2001 05:26:31 -0400
From: COTTE@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Andries.Brouwer@cwi.nl
cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Message-ID: <C1256A65.0033CE5A.00@d12mta11.de.ibm.com>
Date: Fri, 8 Jun 2001 11:21:16 +0200
Subject: Re: [PATCH] Re: BUG: race-cond with partition-check
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Andries!

>Ah, yes. This second assignment can just be deleted, I suppose.
>
>[In the good old days it wasn't there. It was added in 1.3.19,
>don't know why, probably as a safeguard to make sure nobody
>used these values while they are being set up. But someone
>was bit by the assignment, since it is not undone if we take
>the return, so in 2.3.48 the assignment was moved past the
>return, with a conditional assignment before it. I believe
>you are right, and we only want the conditional assignment.]
>
>Andries

Thank you _very_ much for looking into it and accepting my suggestion.
Your patch will fix the problem perfectly good.

with kind regards
Carsten Otte

IBM Deutschland Entwicklung GmbH
Linux for 390/zSeries Development - Device Driver Team
Phone: +49/07031/16-4076
IBM internal phone: *120-4076
--
We are Linux.
Resistance indicates that you're missing the point!


