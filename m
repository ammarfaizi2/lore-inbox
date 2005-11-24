Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbVKXXig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbVKXXig (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 18:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161073AbVKXXig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 18:38:36 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:39980 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161072AbVKXXif convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 18:38:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MkUFmeMuGJjWWTXTxgpCGpi5d5fi7wrSvDPTJQmyXFlKEVrYuyJegbjZPd+LzseNKO4Mx5qVw4kwvtgjLW3PmSoB/eHUpHJWufD9uMIQ1ujvf6iJS4w4Bxqk2OLgOFKiOoMDB8dVxf9zRT42RAGp5Q6Wvs+plxW5hqznQduFRoU=
Message-ID: <5a4c581d0511241538s496adee9s249cd038501545c9@mail.gmail.com>
Date: Fri, 25 Nov 2005 00:38:32 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ipw2200 in 2.6.15-rc2-git4 warns about improper NETDEV_TX_BUSY retcode
Cc: netdev@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dell Latitude D610, FC4 base distro, kernel is:

[asuardi@sandman ~]$ cat /proc/version
Linux version 2.6.15-rc2-git4 (asuardi@sandman) (gcc version 4.0.1
20050727 (Red Hat 4.0.1-5)) #2 Fri Nov 25 00:15:46 CET 2005

Onboard wireless card as detected by kernel is:
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8

 and I placed the 2.4 firmware from sourceforge.net in /lib/firmware.

ifup eth1 yields this message:

eth1: NETDEV_TX_BUSY returned; driver should report queue full via
ieee_device->is_queue_full.


I'm connected to my wireless DSL router while typing this mail
 so it obviously isn't fatal...


Thanks,

--alessandro

 "So much can happen by accident
  No rhyme, no reason - no one's innocent"

   (Steve Wynn - "Under The Weather")
