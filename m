Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266682AbUHCPua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266682AbUHCPua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 11:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266670AbUHCPua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 11:50:30 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:63377 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S266682AbUHCPu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 11:50:28 -0400
Message-Id: <200408031550.i73FoLlS004534@laptop2.inf.utfsm.cl>
To: Bill Davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problems 
In-Reply-To: Message from Bill Davidsen <davidsen@tmr.com> 
   of "Mon, 02 Aug 2004 12:41:44 -0400." <celqbj$gh9$1@gatekeeper.tmr.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 03 Aug 2004 11:50:21 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> said:
> Jens Axboe wrote:
> > On Fri, Jul 30 2004, Zinx Verituse wrote:
> > 
> >>I'm going to bump this topic a bit, since it's been a while..
> >>There are still some issues with ide-cd's SG_IO, listed from
> >>most important as percieved by me to least:
> >>
> >> * Read-only access grants you the ability to write/blank media in the drive
> >> * (with above) You can open the device only in read-only mode.

> > That's by design. Search linux-scsi or this list for why that is so.

> So is the only solution to disallow user access to the device? 
> Operationally that is inconvenient in some cases, but every user 
> community has a few ill-intentioned people, and student groups may be 
> somewhat heavy on that. Security is more important than convenience, but 
> both are desirable.

Right. It is called "compromise".

> We could go to burning all local reference data on CD-R instead of 
> CD-RW, have a separate CD-R drive, but as noted all of those are 
> undesirable drains on time and money. Clearly having some twit rewite 
> the CD-RW with their own information is even more undesirable, if that 
> wasn't clear ;-)

OK, what prevents said twit from bringing in their own (doctored) CD-R in
any case?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
