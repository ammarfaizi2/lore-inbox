Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316786AbSHGDw6>; Tue, 6 Aug 2002 23:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316789AbSHGDw6>; Tue, 6 Aug 2002 23:52:58 -0400
Received: from ool-182fa350.dyn.optonline.net ([24.47.163.80]:58497 "EHLO
	nikolas.hn.org") by vger.kernel.org with ESMTP id <S316786AbSHGDw6>;
	Tue, 6 Aug 2002 23:52:58 -0400
Date: Tue, 6 Aug 2002 23:56:23 -0400
From: Nick Orlov <nick.orlov@mail.ru>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
Message-ID: <20020807035623.GA3411@nikolas.hn.org>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <20020806043304.GA8272@nikolas.hn.org> <Pine.LNX.3.96.1020806230434.9964C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020806230434.9964C-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 11:09:14PM -0400, Bill Davidsen wrote:
> 
> > 2. on most hardware, pdc20xxx is really additional controller.
> 
> That's the problem, most not all. No matter what we assume it will be
> wrong part of the time.

Agreed.

> 
> > 3. if we put pdc20265 in "onboard" list on some hardware (mine for example)
> > pdc20265 is assigned to ide0/1 (even if it's really ide2/3)
> 
> Does this matter as long as we can force it to be where we want? 

But wouldn't it be a cleaner solution if we will have _compile_ time
option that by default is turned on in order to handle rare cases,
and _can_ be turned off in order to handle _most_ cases without any
boot-time options?


-- 
With best wishes,
	Nick Orlov.

