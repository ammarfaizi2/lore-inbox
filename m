Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268714AbRHPN3h>; Thu, 16 Aug 2001 09:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271225AbRHPN32>; Thu, 16 Aug 2001 09:29:28 -0400
Received: from mite-b0-a.infonet.cz ([212.71.188.65]:33035 "EHLO
	mite.infonet.cz") by vger.kernel.org with ESMTP id <S268714AbRHPN3S>;
	Thu, 16 Aug 2001 09:29:18 -0400
Message-ID: <3B7BCAB1.9040700@infonet.cz>
Date: Thu, 16 Aug 2001 15:29:21 +0200
From: Marian Jancar <marian.jancar@infonet.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.7 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: cs, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [zebra 10019] Re: Can't find originating ASBR route
In-Reply-To: <01be01c0f5c4$ccbb5c80$10e27ac3@marshal>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Y. Zhukov wrote:

 > Hello
 >
 > After 2-3 hours jobs ospfd (but not always, some day sometimes works) stops
 > correctly to work and produces in log file:
 >
 > OSPF: Route[External]: Calculate AS-external-LSA to 195.122.226.216/29
 > OSPF: Route[External]: Can't find originating ASBR route
 >
 > And so for all paths. I can give what information when there will occur such
 > moment. Four Cisco-router in same network is normal work.

After upgrading Linux kernel from 2.2.16 to 2.2.19 my ospfd has similar
behaviour (a little while after started). The route is droped and usualy after
one or more hellos reinstated. I tried latest cvs, doesnt help. I would like
to correct this, but I dont have enough knowlege about ospf to do it myself,
any help or hints are wellcome.

Marian Jancar


