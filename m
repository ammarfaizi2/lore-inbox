Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310495AbSCGUAg>; Thu, 7 Mar 2002 15:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310496AbSCGUA0>; Thu, 7 Mar 2002 15:00:26 -0500
Received: from mail.internet-factory.de ([195.122.142.5]:47746 "EHLO
	mail.internet-factory.de") by vger.kernel.org with ESMTP
	id <S310495AbSCGUAM>; Thu, 7 Mar 2002 15:00:12 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: 160gb maxtor with promise ultra 100
Date: Thu, 07 Mar 2002 21:00:11 +0100
Organization: Internet Factory AG
Message-ID: <3C87C6CB.F05C3B96@internet-factory.de>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 1015531211 3331 195.122.142.158 (7 Mar 2002 20:00:11 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 7 Mar 2002 20:00:11 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19-pre2-ac3 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

recently i installed two 160gb maxtor drives. using the latest ac-kernel
(.19-pre2-ac3), they were detected correctly. however, the promise ultra
100 (detected as pdc 20267) hangs at the partition check. last thing it
prints is "hde:" and it's dead. however, if i connect the drives to the
onboard piix3 ide, they are detected correctly, survive the partition
check, and _do_ work as 160gb drives, but slow (piix3 only supports
mdma2, no udma). if i boot the latest non-ac-kernel available on the
machine (which is the not so recent 2.4.14) the drives are misdetected
as only 137gb (of course, no 48 bit support) but otherwise the machine
works, even with the drives connected to the promise.

so the situation is - either i use the full 160 gb, but only mdma2 data
transfer. or i use udma 100, but only 137 gb of the drives. i can't seem
to have both.

i am out of ideas what might be causing this. of course i could just
throw the promise out and leave the drives connected to the on board
controller, but... other ideas?

tia,
holger
