Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310387AbSCLEFL>; Mon, 11 Mar 2002 23:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310389AbSCLEE7>; Mon, 11 Mar 2002 23:04:59 -0500
Received: from host194.steeleye.com ([216.33.1.194]:58116 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S310387AbSCLEEx>; Mon, 11 Mar 2002 23:04:53 -0500
Message-Id: <200203120404.g2C44mV12800@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: james.bottomley@HansenPartnership.com
Subject: [PATCH: NEW ARCHITECTURE FOR 2.5.6] support for NCR voyager
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Mar 2002 23:04:48 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The major change since the last voyager patch is that the voyager code is 
split out into an arch/i386/voyager directory which hooks into the main line 
code rather than being mixed with it.

The patch is in two parts this time:  The i386 sub-architecture split is 
separated from the addition of the voyager components

http://www.hansenpartnership.com/voyager/files/split-2.5.6.diff (255k)
http://www.hansenpartnership.com/voyager/files/split-2.5.6.BK (100k)
http://www.hansenpartnership.com/voyager/files/voyager-2.5.6.diff (151k)
http://www.hansenpartnership.com/voyager/files/voyager-2.5.6.BK (269k)

(The split diff is pretty huge because it's actually moving files about).  You 
must apply the split diff before applying the voyager one.

James Bottomley


