Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267749AbSLTItv>; Fri, 20 Dec 2002 03:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267751AbSLTItv>; Fri, 20 Dec 2002 03:49:51 -0500
Received: from outbound01.telus.net ([199.185.220.220]:37253 "EHLO
	priv-edtnes61.telusplanet.net") by vger.kernel.org with ESMTP
	id <S267749AbSLTItu>; Fri, 20 Dec 2002 03:49:50 -0500
Subject: 2.4.21-pre2 hdparm Kernel Oops
From: Bob <gillb4@telusplanet.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Dec 2002 01:58:27 -0700
Message-Id: <1040374707.1476.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I haven't seen any discussions about the 2.4.21-pre1 and pre2
kernels kernel panicing when you execute  
/sbin/hdparm -d1 -c3 -m16 -k1 /dev/hdb
/sbin/hdparm -d1 -c3 -m16 -k1 /dev/hda

(where /dev/hda contains both my boot and root partitions).

I ran this command in a startup script to improve disk performance.  It
would cause the kernel to panic on startup.  I commented it out of the
script, and the newly built kernels would startup and run OK, but when I
went back and re-ran the script (with the now running system), it would
crash the box.  I installed a new version of hdparm (5.3) to make sure
it wasn't an old version problem.

Thanks in advance, apologies if it's already been looked at, or if it's
just me.

Bob   



