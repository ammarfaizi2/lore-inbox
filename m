Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261659AbTCMBLc>; Wed, 12 Mar 2003 20:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbTCMBLc>; Wed, 12 Mar 2003 20:11:32 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:23994 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S261659AbTCMBLb>;
	Wed, 12 Mar 2003 20:11:31 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.64-mm2->4 hangs on contest
Date: Thu, 13 Mar 2003 12:22:12 +1100
User-Agent: KMail/1.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
References: <5.2.0.9.2.20030312113354.00c8dcc0@pop.gmx.net> <5.2.0.9.2.20030312132025.00c97520@pop.gmx.net>
In-Reply-To: <5.2.0.9.2.20030312132025.00c97520@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303131222.12588.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Mar 2003 23:30, Mike Galbraith wrote:
> At 10:19 PM 3/12/2003 +1100, Con Kolivas wrote:
> >On Wed, 12 Mar 2003 21:37, Mike Galbraith wrote:
> > > >Is this in addition to your previous errr hack or instead of?
> > >
> > > Instead of.  The buttugly patch destroyed interactivity.  This one
> > > cures starvation, and interactivity is really nice.
> >
> >Ok that fixes the "getting stuck in process load" but it still hangs on
> >contest. I'll just have to give mm5 a go and see if whatever problem that
> > was went away in the mean time.
>
> (%$&#!!)

No need to curse. Turns out this is an unrelated bug with the anticipatory 
scheduler which akpm is onto. Your fix worked fine for the scheduler based 
hang.

> Oh well, Ingo probably has it nailed already anyway.

> (but meanwhile, where's your website again?)

contest? 
http://contest.kolivas.org

Con
