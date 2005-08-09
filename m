Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVHITrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVHITrA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 15:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbVHITrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 15:47:00 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:55341 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932360AbVHITq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 15:46:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=ZixxDcdtL6xxuADGyeJwRFazsqezmk84w+sv28OvxW9Bm8TYJ4ZDUvA539M6ujfSj9ge5gkg5a7KKIMLggqcOHTZ5JuJRNFJqE54qd2JBVXsigbeY/aFkgjvz0e1F9c9qpDyYqh2QuLKR8FJQ2h9kzFTlDOAOuRRLmQYq6SaQ5Q=
Date: Tue, 9 Aug 2005 23:55:14 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Achim Leubner <achim_leubner@adaptec.com>
Subject: [PATCH] gdth: schedule GDTIOCTL_OSVERS for removal
Message-ID: <20050809195514.GA10945@mipter.zuzino.mipt.ru>
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
+++ linux-gdth/Documentation/feature-removal-schedule.txt
@@ -135,3 +135,11 @@ Why:	With the 16-bit PCMCIA subsystem no
 	pcmciautils package available at
 	http://kernel.org/pub/linux/utils/kernel/pcmcia/
 Who:	Dominik Brodowski <linux@brodo.de>
+
+---------------------------
+
+What:	GDTIOCTL_OSVERS ioctl
+When:	November 2005
+Files:	drivers/scsi/gdth.c, drivers/scsi/gdth.h
+Why:	Duplicates uname(2).
+Who:	Alexey Dobriyan <adobriyan@gmail.com>

