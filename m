Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266821AbUH0SIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266821AbUH0SIt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266830AbUH0SIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:08:48 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2761 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266821AbUH0SIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:08:40 -0400
Subject: Re: [PATCH] Configure IDE probe delays
From: Lee Revell <rlrevell@joe-job.com>
To: bzolnier@milosz.na.pl
Cc: Greg Stark <gsstark@mit.edu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Todd Poynor <tpoynor@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
In-Reply-To: <200408272005.08407.bzolnier@elka.pw.edu.pl>
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>
	 <87wtzkmq4l.fsf@stark.xeocode.com>
	 <1093629202.837.37.camel@krustophenia.net>
	 <200408272005.08407.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1093630121.837.39.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 27 Aug 2004 14:08:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-27 at 14:05, Bartlomiej Zolnierkiewicz wrote:
> On Friday 27 August 2004 19:53, Lee Revell wrote:
> > On Fri, 2004-08-27 at 13:45, Greg Stark wrote:
> > > Lee Revell <rlrevell@joe-job.com> writes:
> > > > I wonder if 83 probes are really necessary.  Maybe this could be
> > > > optimized a bit.
> > >
> > > Or if the kernel could be doing something useful during that time. I
> > > don't suppose it's possible to probe two different ide interfaces at the
> > > same time, is it?
> >
> > Did the patch to move this into a #define ever get merged?  Seems like a
> > no brainer, as it eliminates a magic number.
> 
> No and it won't because it is not a 'magic number' but rather a 'random 
> number' (see Alan's mail for explanation).
> 

OK, sorry.  Missed that one the first time.

> BTW Lee, 48-bit addressing doesn't mean that capacity > 137GB
> 

What determines whether 48 bit addressing will be used then?

Lee

