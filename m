Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318497AbSHUPnY>; Wed, 21 Aug 2002 11:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318500AbSHUPnY>; Wed, 21 Aug 2002 11:43:24 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:26859 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S318497AbSHUPnX>;
	Wed, 21 Aug 2002 11:43:23 -0400
Message-ID: <3D63B612.8020706@acm.org>
Date: Wed, 21 Aug 2002 10:47:30 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] IPMI driver for Linux
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been working on an IPMI driver for Linux for MontaVista, and I 
think it's ready to see the light of day :-).  I would like to see this 
included in the mainstream kernel eventually.   You can get it at 
http://home.attbi.com/~minyard.  It should work on any kernel version, 
although you will have to fix up the Config.in and Makefile, and the 
Configure.help stuff may not work (it's currently in the 2.4 location).

The web page has documentation on the driver, and documentation is 
included in the patch, too.  This is a fairly full-featured driver with 
a watchdog, panic event generation, full kernel and userland access to 
the driver, multi-user/multi-interface support, and emulators for other 
IPMI device drivers.

-Corey
minyard@acm.org

