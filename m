Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965182AbVH0OfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbVH0OfT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 10:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbVH0OfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 10:35:19 -0400
Received: from web33312.mail.mud.yahoo.com ([68.142.206.127]:15548 "HELO
	web33312.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751619AbVH0OfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 10:35:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VJ76C6CN3XqKiXWqfBgXSJdxdUbH3RGvbT5ltsgm3P02NKbZc1ntn58SnuNSEo/n+hJpgHHiRHOZqeL7o7TwsNNsSbTqMgOksw3j7/h8hnQgcXda42F9sVYZYfpXre1+4Grv93FLImWwnilBePzrGH2Q1j95rc8l4JbRdlJCx4k=  ;
Message-ID: <20050827143517.19566.qmail@web33312.mail.mud.yahoo.com>
Date: Sat, 27 Aug 2005 07:35:16 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: Ben Greear <greearb@candelatech.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20050827111904.GA6484@tentacle.sectorb.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- "Vladimir B. Savkin" <master@sectorb.msk.ru>
wrote:

> On Wed, Aug 24, 2005 at 11:08:43PM -0700,
> Danial Thom wrote:
> > If your test is still set up, try compiling
> > something large while doing the test. The
> drops
> > go through the roof in my tests.
> > 
> Couldn't this happen because ksoftirqd by
> default 
> has a nice value of 19?
> 
> ~
> :wq
>                                         With
> best regards, 
>                                           
> Vladimir Savkin. 

renicing ksoftirqd improves it a bit, but
still tons of loss, even at only 120Kpps.


Danial


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
