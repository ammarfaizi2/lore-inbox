Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSEAINL>; Wed, 1 May 2002 04:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315341AbSEAINK>; Wed, 1 May 2002 04:13:10 -0400
Received: from smtp-server6.tampabay.rr.com ([65.32.1.43]:50383 "EHLO
	smtp-server6.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S315337AbSEAINJ>; Wed, 1 May 2002 04:13:09 -0400
Message-ID: <3CCFA3BD.664EE747@cfl.rr.com>
Date: Wed, 01 May 2002 04:13:49 -0400
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: conman@kolivas.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Combined low latency & performance patches for 2.4.18
In-Reply-To: <20020429142443.A62481333@pc.kolivas.net> <3CCD7A07.D661110E@compro.net> <20020430230105.D5CA01A0AA@pc.kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> On Tue, 30 Apr 2002 02:51, you wrote:
> > After applying it, if you ever do a make mrproper oldconfig dep bzImage it
> > fails to compile sched.c as follows
> 
> > If I don't  do an mrproper it compiles ok. Haven't tested yet.
> 
> Hmm
> I used a make mrproper && make clean followed by manual configuration without
> any problems but thanks for your input. I'm not claiming to be a patch or
> kernel guru. Just offering what worked for me.
> 
> > It's the O1 sched patch. Not your fault....
> 
> Thanks thats kinda reassuring :)
> 
> Con.
> 

I take that back. It's the low-latency patch. You must have said no to
it in your .config.
I do not think all these patches play well together with the O(1)

-- 
Mark Hounschell
dmarkh@cfl.rr.com
