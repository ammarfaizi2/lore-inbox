Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269716AbRHCXvO>; Fri, 3 Aug 2001 19:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269721AbRHCXvE>; Fri, 3 Aug 2001 19:51:04 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:50186 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269717AbRHCXuw>; Fri, 3 Aug 2001 19:50:52 -0400
Date: Fri, 3 Aug 2001 19:21:26 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: BERECZ Szabolcs <szabi@inf.elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kswapd eats the cpu without swap
In-Reply-To: <Pine.A41.4.31.0108012357130.28452-100000@pandora.inf.elte.hu>
Message-ID: <Pine.LNX.4.21.0108031920410.8951-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Aug 2001, BERECZ Szabolcs wrote:

> Hi!
> 
> kernel is 2.4.7-ac3 with the used-once patch.

> I have 160M of ram, and I don't use swap at all, but some minutes before
> kswapd was eating lot's of cpu (98-100%). the system did not responded for
> some 10 seconds, then it worked for some seconds, then it did not responded
> again, until I did a swapon. after adding the swap to the system, it
> swapped out 148k then everything was ok. kswapd still eat some of the cpu
> (0.5% of a k6-2/450). then swapoff, and everything is OK, again.


Does the problem happen only with the used-once patch ? 

If it also happens without the used-once patch, can you reproduce the
problem with 2.4.6 ? 

Thanks 

