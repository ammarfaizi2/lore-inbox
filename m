Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261281AbTCJKjM>; Mon, 10 Mar 2003 05:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261282AbTCJKjM>; Mon, 10 Mar 2003 05:39:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:18534 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261281AbTCJKjL>;
	Mon, 10 Mar 2003 05:39:11 -0500
Message-Id: <5.2.0.9.2.20030310115141.00cecea0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 10 Mar 2003 11:54:23 +0100
To: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.64-mm2->4 hangs on contest
Cc: Andrew Morton <akpm@digeo.com>
In-Reply-To: <200303102142.39366.kernel@kolivas.org>
References: <5.2.0.9.2.20030310114251.00ce5228@pop.gmx.net>
 <5.2.0.9.2.20030310113024.02080868@pop.gmx.net>
 <5.2.0.9.2.20030310114251.00ce5228@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:42 PM 3/10/2003 +1100, Con Kolivas wrote:
>On Mon, 10 Mar 2003 21:43, Mike Galbraith wrote:
> > At 09:31 PM 3/10/2003 +1100, Con Kolivas wrote:
> > >On Mon, 10 Mar 2003 21:31, Mike Galbraith wrote:
> > > > Ahem.  Attached this time.
> > >
> > >I assume this is against bk? I'll massage it into 2.5.64-mm4
> >
> > It's against 2.5.64-combo.
>
>Ok tested and it fixes it. Now what?
>
>Just for the record this is the version I have modified it to on 2.5.64-mm4:
>
>         sleep_avg = (p->sleep_avg + sleep_time) / (1 + rq->nr_running);

Wait for Ingo to say "why in GOD's name would anyone do something _so_ 
stupid!" ?:))) 

