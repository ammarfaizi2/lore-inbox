Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264189AbTFDV2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264193AbTFDV2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:28:04 -0400
Received: from uk134.internetdsl.tpnet.pl ([80.55.140.134]:45828 "EHLO
	cyborg.podlas36.one.pl") by vger.kernel.org with ESMTP
	id S264189AbTFDV2C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:28:02 -0400
From: Krzysiek Taraszka <dzimi@pld.org.pl>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: -rc7   Re: Linux 2.4.21-rc6
Date: Wed, 4 Jun 2003 23:41:27 +0200
User-Agent: KMail/1.5.2
Cc: Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <200305292218.38127.dzimi@pld.org.pl> <Pine.LNX.4.55L.0306041515050.11972@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0306041515050.11972@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200306042341.27160.dzimi@pld.org.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Wednesday 04 of June 2003 20:17, Marcelo Tosatti napisa³:
> On Thu, 29 May 2003, Krzysiek Taraszka wrote:
> > Dnia czw 29. maja 2003 21:56, Krzysiek Taraszka napisa?:
> > > Dnia czw 29. maja 2003 21:11, Marcelo Tosatti napisa?:
> > > > On Thu, 29 May 2003, Georg Nikodym wrote:
> > > > > On Wed, 28 May 2003 21:55:39 -0300 (BRT)
> > > > >
> > > > > Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> > > > > > Here goes -rc6. I've decided to delay 2.4.21 a bit and try
> > > > > > Andrew's fix for the IO stalls/deadlocks.
> > > > >
> > > > > While others may be dubious about the efficacy of this patch, I've
> > > > > been running -rc6 on my laptop now since sometime last night and
> > > > > have seen nothing odd.
> > > > >
> > > > > In case anybody cares, I'm using both ide and a ieee1394 (for a
> > > > > large external drive [which implies scsi]) and I do a _lot_ of big
> > > > > work with BK so I was seeing the problem within hours previously.
> > > >
> > > > Great!
> > > >
> > > > -rc7 will have to be released due to some problems :(
> > >
> > > hmm, seems to ide modules and others are broken. Im looking for reason
> > > why
> >
> > hmm, for IDE subsystem the ide-proc.o was't made for CONFIG_BLK_DEV_IDE=m
> > ... anyone goes to fix it ? or shall I prepare and send here my own patch
> > ?
>
> Feel free to send your own patch, please :)

Hm, I send it few days ago (replay to Andrzej Krzysztofowicz post (sth with 
-rc3 in subject :)) with another fixes but without cmd640 fixes.
Alan made almoust the same changes but him ac tree still have got broken 
cmd640 modular driver (cmd640_vlb still is unresolved).
I tried hack it .. but I droped it ... maybe tomorrow i back to that code ... 
or someone goes to fix it (maybe Alan ?)

-- 
Krzysiek Taraszka			(dzimi@pld.org.pl)
http://cyborg.kernel.pl/~dzimi/

