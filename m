Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266464AbRHKDvA>; Fri, 10 Aug 2001 23:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270710AbRHKDuv>; Fri, 10 Aug 2001 23:50:51 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:39431 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S266464AbRHKDuj>; Fri, 10 Aug 2001 23:50:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Rik van Riel <riel@conectiva.com.br>, David Ford <david@blue-labs.org>
Subject: Re: VM nuisance
Date: Fri, 10 Aug 2001 23:50:50 -0400
X-Mailer: KMail [version 1.3]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108102347050.3530-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108102347050.3530-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010811035043Z266464-760+17@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maybe these are signs that the OOM killer just wasn't ready for 2.4 with the 
VM that it has.   For people hoping to use 2.4 as a server platform, they 
should have the confidence to know what's going to happen when the OOM 
situation occurs.   If the current OOM handler cant give that confidence then 
perhaps it should be removed and slated for 2.5.     Simple way to beat the 
flames anyway.  


On Friday 10 August 2001 22:48, Rik van Riel wrote:
> On Fri, 10 Aug 2001, David Ford wrote:
> > Is there anything measurably useful in any -ac or -pre patches after
> > 2.4.7 that helps or fixes the blasted out-of-memory-but-let's-go-fsck
> > -ourselves-for-a-few-hours?
>
> No.  The problem is that whenever I change something to
> the OOM killer I get flamed.
>
> Both by the people for whom the OOM killer kicks in too
> early and by the people for whom the OOM killer now doesn't
> kick in.
>
> I haven't got the faintest idea how to come up with an OOM
> killer which does the right thing for everybody.
>
> regards,
>
> Rik
> --
> IA64: a worthy successor to i860.
>
> http://www.surriel.com/		http://distro.conectiva.com/
>
> Send all your spam to aardvark@nl.linux.org (spam digging piggy)
