Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264768AbUEYTGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264768AbUEYTGr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbUEYTGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:06:46 -0400
Received: from blv-smtpout-01.boeing.com ([130.76.32.69]:41972 "EHLO
	blv-smtpout-01.boeing.com") by vger.kernel.org with ESMTP
	id S264768AbUEYTGo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:06:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Modifying kernel so that non-root users have some root capabilities
Date: Tue, 25 May 2004 12:06:32 -0700
Message-ID: <67B3A7DA6591BE439001F2736233351202B47EF0@xch-nw-28.nw.nos.boeing.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Modifying kernel so that non-root users have some root capabilities
Thread-Index: AcRCg+JZXrVzxFF5QrypjQiQ+Gf7UAAB2tuw
From: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
To: "Bill Davidsen" <davidsen@tmr.com>, <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 May 2004 19:06:32.0238 (UTC) FILETIME=[64363CE0:01C4428B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Bill Davidsen [mailto:davidsen@tmr.com] 
> Sent: Tuesday, May 25, 2004 11:14 AM
> To: root@chaos.analogic.com
> Cc: Laughlin, Joseph V; linux-kernel@vger.kernel.org
> Subject: Re: Modifying kernel so that non-root users have 
> some root capabilities
> 
> 
> Richard B. Johnson wrote:
> > On Mon, 24 May 2004, Laughlin, Joseph V wrote:
> > 
> > 
> >>(not sure if this is a duplicate or not.. Apologies in advance.)
> >>
> >>I've been tasked with modifying a 2.4 kernel so that a 
> non-root user 
> >>can do the following:
> >>
> >>Dynamically change the priorities of processes (up and down) Lock 
> >>processes in memory Can change process cpu affinity
> >>
> >>Anyone got any ideas about how I could start doing this?  
> (I'm new to 
> >>kernel development, btw.)
> >>
> >>Thanks,
> > 
> > 
> > You don't modify an operating system to do that!! You just make a 
> > priviliged program (setuid) that does the things you want.
> 
> Dick, it's called capabilities, and people have already modified the 
> operating system to do that, it just doesn't work quite as 
> intended in 
> some cases. Setuid is the keys to the kingdom, you really 
> don't want to 
> use setuid root unless there's no other way.
> 
> Remember when everything used to take the BKL? Then people 
> saw a better 
> way. Capabilities is the same kind of progression, save the 
> big hammer 
> for the big nail.
> 

In what cases does changing the capabilities not have the intended
effects?

Thanks,
Joe 
