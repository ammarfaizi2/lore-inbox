Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136232AbRDVRjh>; Sun, 22 Apr 2001 13:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136236AbRDVRj2>; Sun, 22 Apr 2001 13:39:28 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.5.17]:58617 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S136233AbRDVRjW>; Sun, 22 Apr 2001 13:39:22 -0400
Date: Sun, 22 Apr 2001 13:39:43 -0400
From: Alexander Valys <avalys@optonline.net>
Subject: ATA66 on a Via Chipset
To: linux-kernel@vger.kernel.org
Message-id: <01042213394300.23387@athena>
Organization: Valys Technology Solutions
MIME-version: 1.0
X-Mailer: KMail [version 1.2]
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, I decided to try out Debian 2.2.  I downloaded the iso, installed 
it, and went to compile kernel 2.4.3.  I used the same .config file I've used 
before, containing all the appropriate support (ATA66, notably) for my Via 
Apollo Pro133A-based motherboard, installed it, and rebooted.  To make sure 
everything worked correctly, I ran hdparm -t /dev/hda, and was amazed to see 
transfer rates of 22 megs/second.  In redhat, the most I can get is 15.  So, 
I immediately reinstalled redhat, and (using the same .config file), compiled 
the kernel again.  After rebooting, my transfer rates were still 15 
megs/second.  So, my question is - why were they so much faster in debian, 
and how can I replicate that in redhat?
					--A. Valys
