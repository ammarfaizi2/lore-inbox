Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261784AbTCMA0C>; Wed, 12 Mar 2003 19:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261796AbTCMA0C>; Wed, 12 Mar 2003 19:26:02 -0500
Received: from ponch.itc.health.ufl.edu ([159.178.78.204]:55017 "EHLO
	ponch.itc.health.ufl.edu") by vger.kernel.org with ESMTP
	id <S261784AbTCMA0C>; Wed, 12 Mar 2003 19:26:02 -0500
Message-ID: <1047515807.3e6fd29f92939@webmail.health.ufl.edu>
Date: Wed, 12 Mar 2003 19:36:47 -0500
From: sridhar vaidyanathan <sridharv@ufl.edu>
To: linux-kernel@vger.kernel.org
Subject: mmaping /dev/mem
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 163.181.250.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have a problem mmaping /dev/mem on some address in RAM. I am aware of 
caveats,but I am trying to mmap a region which I am sure is not in use by the 
kernel(some additional code does this and returns a physical address which is 
what I use for mmap). The mmap call itself succeeds and /proc/pid/maps also 
shows that region, but I am unable to see what I write in target memory.I also 
tried with the O_SYNC flag as I was wondering is caching had anything to do 
with the results that I was seeing.No effect.
This however works with a mem= option and when the mmap region falls out of the 
mem= boundary.
any clues?
Please cc as I am not subscribed
sridhar

