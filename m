Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272781AbTG3Gjl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 02:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272786AbTG3Ghc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 02:37:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:44164 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272787AbTG3GhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 02:37:05 -0400
Date: Tue, 29 Jul 2003 23:32:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: another must-fix: major PS/2 mouse problem
Message-Id: <20030729233228.53d68237.akpm@osdl.org>
In-Reply-To: <20030730050857.GF2601@openzaurus.ucw.cz>
References: <3EDCF47A.1060605@ifrance.com>
	<1054681254.22103.3750.camel@cube>
	<3EDD8850.9060808@ifrance.com>
	<1058921044.943.12.camel@cube>
	<20030724103047.31e91a96.akpm@osdl.org>
	<1059097601.1220.75.camel@cube>
	<20030725201914.644b020c.akpm@osdl.org>
	<Pine.LNX.4.53.0307261112590.12159@montezuma.mastecende.com>
	<1059447325.3862.86.camel@cube>
	<20030728201459.78c8c7c6.akpm@osdl.org>
	<20030730050857.GF2601@openzaurus.ucw.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> > > Loosing too many ticks!
> > > TSC cannot be used as a timesource. (Are you running with SpeedStep?)
> > > Falling back to a sane timesource.
> > > psmouse.c: Lost synchronization, throwing 3 bytes away.
> > > psmouse.c: Lost synchronization, throwing 1 bytes away.
> > > 
> > > Arrrrgh! The TSC is my only good time source!
> > 
> > Arrrgh!  More PS/2 problems!
> > 
> > I think the lost synchronisation is the problem, would you agree?
> > 
> > The person who fixes this gets a Nobel prize.
> 
> 
> If you set ps/2 synchronization timeout to 20 seconds, you are going to make vojtech
> unhappy (he likes that code :-), but at least 2.6.0 will not be worse than 2.4.x...

2.6 is currently much worse than 2.4: we're buried in what appear to be
many different varieties of PS/2 bug reports.


> Do you want me to create a patch?

Well I do not know what the problem with synchronisation is, not what
solution you propose.

But yeah, I like patches ;)


