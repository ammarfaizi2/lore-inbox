Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbVHITzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVHITzZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 15:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVHITzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 15:55:25 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:55849 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932417AbVHITzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 15:55:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=WKG7D4iCdBFtxe8VA5lmikjrrhlC0ZUKpkTIl7DUb0AMDRaT36uiSMFKCn9mP+CLzX70wv7pN6yFNd/0X86J4GsjnfnkZxR2t26RlJgCP714zBZNw2uJzReeV252p23uqn28jp+YHaVMO6HhD6s3a9TQV01jbmBTMQlKh7D7MpM=
Date: Wed, 10 Aug 2005 00:03:42 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Kevin Curtis <kevin.curtis@farsite.co.uk>
Subject: [PATCH] farsync: schedule struct fstioc_info::kernelVersion for removal
Message-ID: <20050809200342.GB10945@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/feature-removal-schedule.txt |    8 ++++++++
 1 files changed, 8 insertions(+)

--- linux-vanilla/Documentation/feature-removal-schedule.txt
+++ linux-farsync/Documentation/feature-removal-schedule.txt
@@ -121,6 +121,14 @@ Who:	Grant Coady <gcoady@gmail.com>
 
 ---------------------------
 
+What:	struct fstioc_info::kernelVersion used in FSTGETCONF ioctl
+When:	November 2005
+Files:	drivers/net/wan/farsync.c, drivers/net/wan/farsync.h
+Why:	Duplicates uname(2).
+Who:	Alexey Dobriyan <adobriyan@gmail.com>
+
+---------------------------
+
 What:	PCMCIA control ioctl (needed for pcmcia-cs [cardmgr, cardctl])
 When:	November 2005
 Files:	drivers/pcmcia/: pcmcia_ioctl.c

