Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263148AbTCLLJL>; Wed, 12 Mar 2003 06:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263151AbTCLLJL>; Wed, 12 Mar 2003 06:09:11 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:6837 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S263148AbTCLLJI>;
	Wed, 12 Mar 2003 06:09:08 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.64-mm2->4 hangs on contest
Date: Wed, 12 Mar 2003 22:19:49 +1100
User-Agent: KMail/1.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
References: <5.2.0.9.2.20030312101646.00c8e238@pop.gmx.net> <5.2.0.9.2.20030312113354.00c8dcc0@pop.gmx.net>
In-Reply-To: <5.2.0.9.2.20030312113354.00c8dcc0@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303122219.49195.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Mar 2003 21:37, Mike Galbraith wrote:
> At 09:25 PM 3/12/2003 +1100, Con Kolivas wrote:
> >On Wed, 12 Mar 2003 20:21, Mike Galbraith wrote:
> > > I can't help myself... the attached is just too simple and works too
> > > darn well.
> > >
> > > Somebody stop me! :)
> >
> >Sssssssssssmokin are ya Mike?
>
> ;-)
>
> >Is this in addition to your previous errr hack or instead of?
>
> Instead of.  The buttugly patch destroyed interactivity.  This one cures
> starvation, and interactivity is really nice.

Ok that fixes the "getting stuck in process load" but it still hangs on 
contest. I'll just have to give mm5 a go and see if whatever problem that was 
went away in the mean time.

Con
