Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbTFTTsZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 15:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbTFTTsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 15:48:25 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13262 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264538AbTFTTsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 15:48:24 -0400
Date: Fri, 20 Jun 2003 16:59:58 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: stoffel@lucent.com, gibbs@scsiguy.com, linux-kernel@vger.kernel.org,
       willy@w.ods.org, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
In-Reply-To: <20030618130533.1f2d7205.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.55L.0306201658210.2607@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
 <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com>
 <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com>
 <41560000.1055306361@caspian.scsiguy.com> <20030611222346.0a26729e.skraw@ithnet.com>
 <16103.39056.810025.975744@gargle.gargle.HOWL> <20030613114531.2b7235e7.skraw@ithnet.com>
 <Pine.LNX.4.55L.0306171744280.10802@freak.distro.conectiva>
 <20030618130533.1f2d7205.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Jun 2003, Stephan von Krawczynski wrote:

> On Tue, 17 Jun 2003 17:47:02 -0300 (BRT)
> Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
>
> >
> >
> > On Fri, 13 Jun 2003, Stephan von Krawczynski wrote:
> >
> > > Hello all,
> > >
> > > this is the second day of stress-testing pure rc8 in SMP, apic mode. Today
> > > everything is fine, no freeze, no data corruption.
> > >
> > > current standings:
> > >
> > > 2 days continuous test, one file data corruption on day 1
> >
> >
> > What kind of data corruption and what tests are you doing ? (sorry if you
> > already mentionad that on the list)
>
> Todays score:
>
> 7 days continuous test
> one file data corruption on day 1
> one file data corruption on day 4
> two file data corruptions on day 6
>
> Test is performed as follows:
>
> around 70-100 GB of data is transferred to a nfs-server with rc8 onto a
> RAID5 on 3ware-controller. The data is then copied via tar onto a SDLT
> drive connected to an aic controller. Afterwards the data is verified by
> tar.

So the data is intact when it arrives on the 3ware and gets corrupted
on the write to the tape?

