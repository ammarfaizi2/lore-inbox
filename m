Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318972AbSHFE3o>; Tue, 6 Aug 2002 00:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318976AbSHFE3o>; Tue, 6 Aug 2002 00:29:44 -0400
Received: from ool-182fa350.dyn.optonline.net ([24.47.163.80]:20865 "EHLO
	nikolas.hn.org") by vger.kernel.org with ESMTP id <S318972AbSHFE3o>;
	Tue, 6 Aug 2002 00:29:44 -0400
Date: Tue, 6 Aug 2002 00:33:04 -0400
From: Nick Orlov <nick.orlov@mail.ru>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
Message-ID: <20020806043304.GA8272@nikolas.hn.org>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.SOL.4.30.0208030241540.18115-100000@mion.elka.pw.edu.pl> <Pine.LNX.3.96.1020805234655.4423B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020805234655.4423B-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 11:48:47PM -0400, Bill Davidsen wrote:
> On Sat, 3 Aug 2002, Bartlomiej Zolnierkiewicz wrote:
> 
> > And second problem is that 20265 is used as primary onboard
> > sometimes and sometimes as offboard (another config option?).
> 
> Can that not be configured at boot time with ide0=xxx or similar? I'm
> clearly missing why it would matter on or off board as long as the
> controller(s) were checked in the right order.
> 

I'm not expert in this field, but my current understanding is:

1. ide0/1 reserved for onboard controllers.
2. on most hardware, pdc20xxx is really additional controller.
3. if we put pdc20265 in "onboard" list on some hardware (mine for example)
pdc20265 is assigned to ide0/1 (even if it's really ide2/3)
4. ide0=<what> ??? (do we have this option?)

Correct me, if I'm wrong.

-- 
With best wishes,
	Nick Orlov.

