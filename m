Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131419AbRCXML3>; Sat, 24 Mar 2001 07:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131489AbRCXMLT>; Sat, 24 Mar 2001 07:11:19 -0500
Received: from fe040.world-online.no ([213.142.64.154]:36810 "HELO
	mail.world-online.no") by vger.kernel.org with SMTP
	id <S131419AbRCXMLJ>; Sat, 24 Mar 2001 07:11:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Gerry <gerry@c64.org>
To: linux-kernel@vger.kernel.org
Subject: ..supermount ? no! (The Ultimate Solution :)
Date: Sat, 24 Mar 2001 13:11:15 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01032413111500.00832@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the removable device-drivers to detect change. Fx, with cdrom, change 
the cdrom-part to detect when the disc tray ejects and when it goes back in, 
both for manual (user push eject) and automatic (program sends 
eject-request). This way the kernel just have to send a signal when this 
happens on a device (to processes who have requested to get to know).

This has several advantages:

* Supermount don't need to be kernel-related at all, and so doesn't need to 
be updated for each new kernel revision (cleaner kernel)
* Possible to get autorun on linux
* Can get rid of "insert cd and press ok"-like things (replace with "insert 
cd or press cancel")
* Imagination is the only limit :)

So, what do you say ? (I'm a newbie to this, so don't flame me to hard :)

Gerry
