Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263720AbTFDSGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTFDSGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:06:05 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52188 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263720AbTFDSGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:06:01 -0400
Date: Wed, 4 Jun 2003 15:17:11 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Krzysiek Taraszka <dzimi@pld.org.pl>
Cc: Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: -rc7   Re: Linux 2.4.21-rc6
In-Reply-To: <200305292218.38127.dzimi@pld.org.pl>
Message-ID: <Pine.LNX.4.55L.0306041515050.11972@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
 <Pine.LNX.4.55L.0305291609580.14835@freak.distro.conectiva>
 <200305292156.51618.dzimi@pld.org.pl> <200305292218.38127.dzimi@pld.org.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 May 2003, Krzysiek Taraszka wrote:

> Dnia czw 29. maja 2003 21:56, Krzysiek Taraszka napisa?:
> > Dnia czw 29. maja 2003 21:11, Marcelo Tosatti napisa?:
> > > On Thu, 29 May 2003, Georg Nikodym wrote:
> > > > On Wed, 28 May 2003 21:55:39 -0300 (BRT)
> > > >
> > > > Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> > > > > Here goes -rc6. I've decided to delay 2.4.21 a bit and try Andrew's
> > > > > fix for the IO stalls/deadlocks.
> > > >
> > > > While others may be dubious about the efficacy of this patch, I've been
> > > > running -rc6 on my laptop now since sometime last night and have seen
> > > > nothing odd.
> > > >
> > > > In case anybody cares, I'm using both ide and a ieee1394 (for a large
> > > > external drive [which implies scsi]) and I do a _lot_ of big work with
> > > > BK so I was seeing the problem within hours previously.
> > >
> > > Great!
> > >
> > > -rc7 will have to be released due to some problems :(
> >
> > hmm, seems to ide modules and others are broken. Im looking for reason why
>
> hmm, for IDE subsystem the ide-proc.o was't made for CONFIG_BLK_DEV_IDE=m ...
> anyone goes to fix it ? or shall I prepare and send here my own patch ?

Feel free to send your own patch, please :)
