Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319259AbSIKSL7>; Wed, 11 Sep 2002 14:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319260AbSIKSL7>; Wed, 11 Sep 2002 14:11:59 -0400
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:38287 "EHLO
	rrzs2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S319259AbSIKSL6>; Wed, 11 Sep 2002 14:11:58 -0400
Date: Wed, 11 Sep 2002 20:16:02 +0200
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de, linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
Message-ID: <20020911201602.A13655@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

just tried out 2.4.20-pre5aa2 with xfs enabled as module. But I can't load 
the xfs Module...
modprobe xfs just won't work. Via top on another console I see two modpobe 
processes, each consuming 99.9% CPU time. Then, after a minute or so, the 
machine reboots...

System is a Dell Precision with 2 Intel Xeons@2.2GHz and 2GB RDRAM and 
hyper-threading enabled, OS is Debian/GNU Linux 3.0 with:

gcc-2.95.4 20011002 (Debian prerelease)
ld-2.12.90.0.1 20020307 Debian/GNU Linux


I tried to disable HT, but then it was even worse. Then my machine crashed 
hard after starting "modprobe xfs".


thanks in advance
Christian

P.S. if needed, I could post my .config, or other relevant things...
  
