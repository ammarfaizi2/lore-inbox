Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273345AbRIVFOz>; Sat, 22 Sep 2001 01:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273609AbRIVFOq>; Sat, 22 Sep 2001 01:14:46 -0400
Received: from juicer34.bigpond.com ([139.134.6.86]:8688 "EHLO
	mailin9.bigpond.com") by vger.kernel.org with ESMTP
	id <S273345AbRIVFOe>; Sat, 22 Sep 2001 01:14:34 -0400
Message-Id: <200109220514.f8M5EevF002295@ADSL-Server.davsoft.com.au>
Content-Type: text/plain; charset=US-ASCII
From: David Findlay <david_j_findlay@yahoo.com.au>
Organization: Davsoft
To: linux-kernel@vger.kernel.org
Subject: Bug: Joystick Driver doesn't talk to CMPCI gameports`
Date: Sat, 22 Sep 2001 15:13:14 +1000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a C-Media 8738 card built into my motherboard. The sound works fine.

I use these command as from the joystick documentation:

modprobe cmpci joystick=1
modprobe joydev
modprobe analog

I am using DevFS and kernel 2.4.9. Nothing appears in /dev/input where js0 
should actually appear when I insmod the analog joystick. The results of 
lsmod after doing those commands:

Workshop:/dev/input# lsmod
Module                  Size  Used by
analog                  6960   0  (unused)
gameport                1808   0  [analog]
cmpci                  28416   0

It appears that instead of using the cmpci gameport, it is using the gameport 
driver or something. Could someone please help me either get it going if 
there's a workaround, or otherwise tell me what code to look at to fix it? 
Thanks,

David

P.S. I'm not subscribed so please CC your response to me Thanks,
