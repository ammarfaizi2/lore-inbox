Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316051AbSF0UVS>; Thu, 27 Jun 2002 16:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316079AbSF0UVR>; Thu, 27 Jun 2002 16:21:17 -0400
Received: from ns.escriba.com.br ([200.250.187.130]:51955 "EHLO
	alexnunes.lab.escriba.com.br") by vger.kernel.org with ESMTP
	id <S316051AbSF0UVQ>; Thu, 27 Jun 2002 16:21:16 -0400
Message-ID: <3D1B7440.3040605@PolesApart.wox.org>
Date: Thu, 27 Jun 2002 17:23:28 -0300
From: "Alexandre P. Nunes" <alex@PolesApart.wox.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-rc1 + O(1) scheduler
References: <Pine.LNX.4.44.0206222202400.7601-100000@PolesApart.dhs.org>	<20020626204721.GK22961@holomorphy.com>	<1025125214.1911.40.camel@localhost.localdomain>	<1025128477.1144.3.camel@icbm> <20020627005431.GM22961@holomorphy.com>	<1025192465.1084.3.camel@icbm> <20020627154712.GO22961@holomorphy.com> 	<3D1B5982.60008@PolesApart.dhs.org> <1025202738.1084.12.camel@icbm> <3D1B5F1D.2000706@PolesApart.wox.org> <3D1B7005.2090200@tmsusa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That would be nice... but no -
>
> both -aa and -ac have it though, and it seems
> solid, so maybe there's hope for 2.4 mainline
> getting it eventually.
>
> Joe
>
>
It seems that the version of O(1) scheduler on 2.4.19-pre10-ac2 is not 
perfect (see below), but I asked because it gave me overall performance 
gains, specially in multithreading programs (and now I'm going to try 
with ngpt 2.00). At least that is the first impression, I'm trying it 
for a few days.

I said "not perfect" because a rather non-important benchmarking called 
quake 3 seens a lot worse in pre10-ac2 with preemptive patches when 
compared against -pre10 with preemptive patches: sound and screen popped 
sometimes, like if there was a background task borrowing some cpu, which 
was not the case, I mean, no other background tasks compared with 
testing against -pre10. That was the only exception to the above 
paragraph that I can remember of.

Anyway, that "benchmarking tool" isn't rather serious and I'm no 
benchmarking expert :-)

Thank you,

Alexandre

