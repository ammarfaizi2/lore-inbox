Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVILMMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVILMMd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 08:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVILMMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 08:12:32 -0400
Received: from s1.mailresponder.info ([193.24.237.10]:57105 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S1750778AbVILMMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 08:12:32 -0400
Subject: 2.6.13 brings buffer underruns when burning DVDs at high speeds
	(16x)
From: Mathieu Fluhr <mfluhr@nero.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Nero AG
Date: Mon, 12 Sep 2005 14:11:53 +0200
Message-Id: <1126527113.2169.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

It seems that something has been broken when passing from 2.6.12 to
2.6.13 regarding the SCSI burning engine. When burning a DVD at 16x
(with ide-cd SEND_PACKET command, or with the SG interface, no matter
the driver used), you get tons of buffer underruns. This was not
appearing in 2.6.12.

I would suspect something in the block devices driver, but I am not
really sure... and I did not have enough time yet to look deeply in the
source code ;-)

Best Regards,
Mathieu

