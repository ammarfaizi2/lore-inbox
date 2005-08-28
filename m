Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbVH1QS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbVH1QS4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 12:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbVH1QS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 12:18:56 -0400
Received: from mail.customers.edis.at ([62.99.242.131]:29084 "EHLO
	smtp-1.edis.at") by vger.kernel.org with ESMTP id S1750991AbVH1QSz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 12:18:55 -0400
Message-ID: <4311E3DE.20706@lawatsch.at>
Date: Sun, 28 Aug 2005 18:18:38 +0200
From: Philip Lawatsch <philip@lawatsch.at>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050724 Thunderbird/1.0.6 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel/Box Freezes Under Kernel 2.6.12.5
References: <Pine.LNX.4.63.0508261733400.363@p34> <200508261751.11751.pmcfarland@downeast.net> <Pine.LNX.4.63.0508261805080.363@p34>
In-Reply-To: <Pine.LNX.4.63.0508261805080.363@p34>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:

 > I have three different Maxtor (promise) ATA/133 controllers, it
 > happens with all three.


Ever since going to 2.6.12 I also have random hangs with my fileserver.

I've got a
   Bus  0, device   6, function  0:
     Unknown mass storage controller: Promise Technology, Inc. 20269 
(rev 2).
       IRQ 17.
       Master Capable.  Latency=32.  Min Gnt=4.Max Lat=18.
       I/O at 0xec00 [0xec07].
       I/O at 0xe800 [0xe803].
       I/O at 0xe400 [0xe407].
       I/O at 0xe000 [0xe003].
       I/O at 0xdc00 [0xdc0f].
       Non-prefetchable 32 bit memory at 0xdfffc000 [0xdfffffff].


in the box.

Since I do not have a serial cable attached I dont have the panic 
output. But iirc it crashes somewhere in an interrupt handler 
complaining about damaged pagetables (thats why I thought it was bad 
memory). But it takes about 3 days for the machine to hang (and I'm 
happily using all the memory and have high disk i/o in the meantime).

I'll go and replace the memory but perhaps there really is a bug in the 
driver.

kind regards Philip

