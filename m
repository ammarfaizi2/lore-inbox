Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267058AbTGKXPm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 19:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267063AbTGKXPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 19:15:42 -0400
Received: from asc8-grr-ip023.wmis.net ([63.168.28.123]:260 "EHLO marmot")
	by vger.kernel.org with ESMTP id S267058AbTGKXPl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 19:15:41 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Paul <Ocran@gmx.net>
Reply-To: Ocran@gmx.net
To: linux-kernel@vger.kernel.org
Subject: Promise fasttrack raid, changed disk, unable to boot.
Date: Fri, 11 Jul 2003 19:32:21 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200307111932.21603.Ocran@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
For the previos year i have been using the promise fasttrack 100 to controll 4 
disks. I mirrored 2 75gig drives and 2 80gig drives. Recently one of the 75 
gig drives died on me. This particular mirroring array was the system array. 
So i replaced the disk with an 80 gig one and duplicated it. Now i an unable 
to boot with the previos kernel 2.4.19. But i can boot with the 2.4.18 kernel 
which was provided to be by my distrabution. I have comiled 2.4.19 and 2.4.20 
on the machine itself and another machine to see if i could get one of them 
to work, but i can not. During boot up something like this is listed

ataraid/d0  then the partitions are listed. such as ataraid/d0p1
then the drives are listed
drive0 is 733XXX mb
raid0 consists of 1 drive.

That is how it looks with the new disk plugged in. But if i unplug it.
it will look like this:

drive0 is 733xxx mb
drive1 is 733xxx mb  <--- this tells me that there is something either in the 
kernel or in the system that is telling the kernel what the old disk used to 
be.         

I am completly lost and hope that someone else has an idea of what i should 
do. BTW I have compiled my kernel statically, while the distos 2.4.18 was 
modules, if that makes any difference.

Thank you,
Paul
