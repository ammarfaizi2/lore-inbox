Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUFJAeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUFJAeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 20:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266054AbUFJAeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 20:34:14 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:1988 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266048AbUFJAeM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 20:34:12 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: ide errors in 7-rc1-mm1 and later
Date: Thu, 10 Jun 2004 02:38:11 +0200
User-Agent: KMail/1.5.3
Cc: Jeff Garzik <jgarzik@pobox.com>, Ed Tomlinson <edt@aei.ca>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <1085689455.7831.8.camel@localhost> <20040605092447.GB13641@suse.de> <20040606161827.GC28576@bounceswoosh.org>
In-Reply-To: <20040606161827.GC28576@bounceswoosh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406100238.11857.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/me just thinks loudly

'linear range' FLUSH CACHE seems so easy to implement that I always wondered
why FLUSH CACHE command doesn't make any use of LBA address and number
of sectors.

On Sunday 06 of June 2004 18:18, Eric D. Mudama wrote:
> On Sat, Jun  5 at 11:24, Jens Axboe wrote:
> >I did suggest this a few years ago. The comment I received was that
> >they didn't take suggestions from OS people, if I didn't have a drive
> >implementation to go with the proposal they couldn't use it for
> >anything. Which was interesting, since that seemed to suggest that t13
> >had little steering in ata development, they mainly put into the ATA
> >specs what drive manufacturers shoved at them. Of course this isn't 100%
> >true, but it does explain a lot of things :-)
>
> If it helps, I'm listening.
>
> Suggestions/proposals for new features etc, if they're a good idea, I
> can help push inside via our SATA/T13 reps.  Note that as per all
> long-lived specs with multiple revisions, changing the behavior of an
> existing feature to something incompatible is virtually never
> feasable.
>
> >Andre even tried getting FUA to do what we needed, no such luck there.
> >Some other bigger OS wanted it differently, the rest is history.
>
> Lo siento, I wasn't around when that occurred.  Of course, that other
> bigger OS has a very large installed base, and selling a drive that
> breaks it is corporate suicide.

