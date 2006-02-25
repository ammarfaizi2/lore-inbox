Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWBYGik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWBYGik (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 01:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWBYGik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 01:38:40 -0500
Received: from i-216-58-89-227.gta.igs.net ([216.58.89.227]:640 "EHLO
	mail.undead.cc") by vger.kernel.org with ESMTP id S1030185AbWBYGij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 01:38:39 -0500
X-AuthUser: john@undead.cc
Message-ID: <43FFFB6B.7090700@undead.cc>
Date: Sat, 25 Feb 2006 01:38:35 -0500
From: John Zielinski <john_ml@undead.cc>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VIA Velocity massive memory corruption with jumbo frames
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just bought a stack of Via Velocity network cards to upgrade my 
network.  I also purchased a Netgear GS-108 Gigabit switch which has 
supports for jumbo frames.   When I tried increasing the MTU to 9000 I 
started getting massive memory corruption.   Some of the symptoms were: 
programs failing to load, random oopses, VT freezes, machine freezes, 
filesystem corruption, etc.  It only happened when the machine was 
receiving network traffic.  The RX count would not advance either for 
that interface.

I tried on another machine and got the same thing.  I even set up a 
fresh install of Linux with the latest kernel on a test box and got the 
same.  Dual booting to Windows on that box works perfect with jumbo 
frames as well as the other two Windows machines on the network with the 
same type of card.  I tried three Linux boxes with the same results.  
Each box has different hardware and configurations.   The original 
machine I tried it on is a dual P3-833 machine running 2.6.10 while the 
test box is a Celeron 800 with a clean install of 2.6.15.4.

I also tried an MTU of 3000 instead of 9000 and got the same thing.

Anyone know what I should try next?



