Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265065AbUFAOIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbUFAOIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 10:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUFAOIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 10:08:34 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:26848 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S265062AbUFAOGI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 10:06:08 -0400
Mime-Version: 1.0
Message-Id: <a06100508bce23dc2143d@[129.98.90.227]>
Date: Tue, 1 Jun 2004 10:06:11 -0400
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: LSI Logic fusion mptscsih driver doesn't see devices under 2.6.x
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a problem with mptscsih under 2.6.5 through 
2.6.7-rc2 when it is run on a dual Opteron based machine and a 
LSI21040 card. It doesn't make the attached disk available. It won't 
show up in /proc/scsi/scsi.

With sym53c8xx and 2.6.5 on this same machine, the drive attached to 
the card shows up just fine.

mptscsih does work under a Xeon based system 2.6.6 and a LSI20320-R card.
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
