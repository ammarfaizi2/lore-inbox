Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272313AbRIFMQO>; Thu, 6 Sep 2001 08:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272464AbRIFMQE>; Thu, 6 Sep 2001 08:16:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4878 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272313AbRIFMPy>; Thu, 6 Sep 2001 08:15:54 -0400
Subject: Re: v2.4.9 and sequential scan
To: conway_heather@emc.com (conway, heather)
Date: Thu, 6 Sep 2001 13:19:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <2CE33F05597DD411AAE800D0B769587C04EA0542@sryoung.lss.emc.com> from "conway, heather" at Sep 06, 2001 08:10:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ey8B-0007yi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> panicking because it times out trying to scan for all of the LUNs.  Same
> thing goes for another host using the Qlogic qla2x00 driver.  
> Is there any timeframe for a change from sequential scanning in v2.4.x or is
> there a work around so the hosts don't panic if they're attached to external
> storage?

It shouldnt be panicing. Scanning is a legal scsi operation. If someone
wants to test and provide proper report luns code I'll be happy to test it
out in the -ac series then feed it on to Linus once stable
