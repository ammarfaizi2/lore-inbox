Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319303AbSIFSax>; Fri, 6 Sep 2002 14:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319323AbSIFSax>; Fri, 6 Sep 2002 14:30:53 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:17167 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S319303AbSIFSav>;
	Fri, 6 Sep 2002 14:30:51 -0400
Message-ID: <3D78F572.2080200@acm.org>
Date: Fri, 06 Sep 2002 13:35:30 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] Version 2 of the Linux IPMI driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've cleaned a few things up and fixed some minor bugs.  The only big 
change is renaming the "unused" address to the "system interface" 
address (which makes a heck of a lot more sense).  I'm working on 
userland tools that will tie in to this and to LAN/ICMB stuff, and there 
I saw the need for the name.  I still haven't tested interrupt-driven 
operation, but that's really a rather minor concern since almost no 
boards support it and the driver will work without it.

You can get the patch on my web page at http://home.attbi.com/~minyard, 
relative to 2.5.33 or 2.4.19.  The patch is fairly self-contained, so it 
should be easy to port to other kernel versions.

The lanana guy is not available for a while, so I'm not getting a device 
number in the near future, but I think it's ready for the 2.5 release. 
 Does this need more time, or is it ready for inclusion?

-Corey

