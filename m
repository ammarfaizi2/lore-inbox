Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281084AbRKOVst>; Thu, 15 Nov 2001 16:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281091AbRKOVs3>; Thu, 15 Nov 2001 16:48:29 -0500
Received: from apollo.wizard.ca ([204.244.205.22]:31245 "HELO apollo.wizard.ca")
	by vger.kernel.org with SMTP id <S281084AbRKOVsY>;
	Thu, 15 Nov 2001 16:48:24 -0500
Subject: Problem with 2.4.14 mounting i2o device as root device Adaptec 3200
	RAID controller?
From: Michael Peddemors <michael@wizard.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 15 Nov 2001 13:53:54 -0800
Message-Id: <1005861234.9918.806.camel@mistress>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It may be an esoteric problem in my config, but I installed a RedHat 7.2
onto an Adaptec (It was strange, I could install one out of 3 tries, but
rebooting into the 2.4.7-pre that ships with RedHat it got to unloading
free memory, paused about 2 minutes, the the screen rolls with unable to
read device messages) 3200s/quantum combination, but it gives me read
problems on the device, with anything more than 512 MG RAM.  Thought it
might be kernel related so tried a freshly rolled 2.4.14 kernel, and it
fails to mount the root point /dev/i2o/hda1 (kernel panic, cannot mount
5001)
Hardware has mostly been ruled out, as we replaced the motherboard/and
controller as well as the mundane cables and terminators...

Is anyone successfully using 2.4.14 on an Adaptec 3200s controller?
This could be a PCI issue, because just we see a lot of interrrupt
activity on the card just before it dies..

Am not using modules, compiled the i20 support directly into 2.4.14

Wanted to get some serious 2.4.14 testing on this platform.. so no
suggestions about rolling back to 2.2 series.. :)

-- 
"Catch the Magic of Linux..."
--------------------------------------------------------
Michael Peddemors - Senior Consultant
LinuxAdministration - Internet Services
NetworkServices - Programming - Security
Wizard IT Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604)589-0037 Beautiful British Columbia, Canada

