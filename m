Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbTE2UFb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTE2UFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:05:30 -0400
Received: from uk134.internetdsl.tpnet.pl ([80.55.140.134]:39172 "EHLO
	cyborg.podlas36.one.pl") by vger.kernel.org with ESMTP
	id S262590AbTE2UFY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:05:24 -0400
From: Krzysiek Taraszka <dzimi@pld.org.pl>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>
Subject: Re: -rc7   Re: Linux 2.4.21-rc6
Date: Thu, 29 May 2003 22:18:38 +0200
User-Agent: KMail/1.5.1
Cc: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <Pine.LNX.4.55L.0305291609580.14835@freak.distro.conectiva> <200305292156.51618.dzimi@pld.org.pl>
In-Reply-To: <200305292156.51618.dzimi@pld.org.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200305292218.38127.dzimi@pld.org.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia czw 29. maja 2003 21:56, Krzysiek Taraszka napisa³:
> Dnia czw 29. maja 2003 21:11, Marcelo Tosatti napisa³:
> > On Thu, 29 May 2003, Georg Nikodym wrote:
> > > On Wed, 28 May 2003 21:55:39 -0300 (BRT)
> > >
> > > Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> > > > Here goes -rc6. I've decided to delay 2.4.21 a bit and try Andrew's
> > > > fix for the IO stalls/deadlocks.
> > >
> > > While others may be dubious about the efficacy of this patch, I've been
> > > running -rc6 on my laptop now since sometime last night and have seen
> > > nothing odd.
> > >
> > > In case anybody cares, I'm using both ide and a ieee1394 (for a large
> > > external drive [which implies scsi]) and I do a _lot_ of big work with
> > > BK so I was seeing the problem within hours previously.
> >
> > Great!
> >
> > -rc7 will have to be released due to some problems :(
>
> hmm, seems to ide modules and others are broken. Im looking for reason why

hmm, for IDE subsystem the ide-proc.o was't made for CONFIG_BLK_DEV_IDE=m ...
anyone goes to fix it ? or shall I prepare and send here my own patch ?

-- 
Krzysiek Taraszka			(dzimi@pld.org.pl)
http://cyborg.kernel.pl/~dzimi/
