Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318134AbSHWC2d>; Thu, 22 Aug 2002 22:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318136AbSHWC2d>; Thu, 22 Aug 2002 22:28:33 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:36669 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S318134AbSHWC2c>;
	Thu, 22 Aug 2002 22:28:32 -0400
Message-ID: <3D659ECA.3010904@acm.org>
Date: Thu, 22 Aug 2002 21:32:42 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] New version of IPMI driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've split up the driver, creating working 2.4.19 and 2.5.31 versions of 
the driver (and even tested them!) and split the emulation code into a 
separate patch.

I also noticed that 2.5.31 timer interrupts occur at 1ms instead of 
10ms, so it should provide acceptable speed without high-res timers. 
 2.4 without high-res timers or interrupts will still be very slow.

I have not yet tested interrupts, because I don't have a card that 
supports them (it's on its way).  However, that's pretty straightforward.

The web page is http://home.attbi.com/~minyard

Please, try it out and tell me what you think.  Again, I'm shooting for 
getting this in the mainstream kernel.

-Corey

