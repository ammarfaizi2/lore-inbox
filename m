Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261276AbTCJKcD>; Mon, 10 Mar 2003 05:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261281AbTCJKcD>; Mon, 10 Mar 2003 05:32:03 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:48284 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S261276AbTCJKcC>;
	Mon, 10 Mar 2003 05:32:02 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64-mm2->4 hangs on contest
Date: Mon, 10 Mar 2003 21:42:39 +1100
User-Agent: KMail/1.5
References: <5.2.0.9.2.20030310113024.02080868@pop.gmx.net> <5.2.0.9.2.20030310114251.00ce5228@pop.gmx.net>
In-Reply-To: <5.2.0.9.2.20030310114251.00ce5228@pop.gmx.net>
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303102142.39366.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Mar 2003 21:43, Mike Galbraith wrote:
> At 09:31 PM 3/10/2003 +1100, Con Kolivas wrote:
> >On Mon, 10 Mar 2003 21:31, Mike Galbraith wrote:
> > > Ahem.  Attached this time.
> >
> >I assume this is against bk? I'll massage it into 2.5.64-mm4
>
> It's against 2.5.64-combo.

Ok tested and it fixes it. Now what?

Just for the record this is the version I have modified it to on 2.5.64-mm4:

	sleep_avg = (p->sleep_avg + sleep_time) / (1 + rq->nr_running);


Con
