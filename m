Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131483AbRDMQL6>; Fri, 13 Apr 2001 12:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131481AbRDMQLq>; Fri, 13 Apr 2001 12:11:46 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:31748 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S131483AbRDMQKi>;
	Fri, 13 Apr 2001 12:10:38 -0400
Message-Id: <200104131205.f3DC5KV11393@sleipnir.valparaiso.cl>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer! 
In-Reply-To: Your message of "Thu, 12 Apr 2001 23:32:31 MST."
             <3AD69D7F.36B2BA87@candelatech.com> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Fri, 13 Apr 2001 08:05:20 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear <greearb@candelatech.com> said:

[...]

> Wouldn't a heap be a good data structure for a list of timers?  Insertion
> is log(n) and finding the one with the least time is O(1), ie pop off the
> front....  It can be implemented in an array which should help cache
> coherency and all those other things they talked about in school :)

Insertion and deleting the first are both O(log N). Plus the array is fixed
size (bad idea) and the jumping around in the array thrashes the caches.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
