Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129876AbRBAAZf>; Wed, 31 Jan 2001 19:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129365AbRBAAZ0>; Wed, 31 Jan 2001 19:25:26 -0500
Received: from mserv1d.vianw.co.uk ([195.102.240.96]:51121 "EHLO
	mserv1d.vianw.co.uk") by vger.kernel.org with ESMTP
	id <S129872AbRBAAZN>; Wed, 31 Jan 2001 19:25:13 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: linux-kernel@vger.kernel.org
Subject: modules as drivers and the order of loading
Date: Thu, 01 Feb 2001 00:28:08 +0000
Organization: [private individual]
Message-ID: <ptah7t4do0ts1cukrnqfs38ok1bd2rlnal@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I was building 2.4.1 afresh I took the opportunity to build some of
the device drivers as modules.  In particular I have a SCSI cdrom
device (it actually is a cd writer) and I had made that and its
controller (Adaptec AIC-7xxx driver) modules.

However, during boot they fail to load because at the time they are
brought up VFS had not mounted the root filesystem

I am not sure why they can be built as modules if they then can't be
loaded?

OR have I completely misunderstood the approach here.

Alan

alan@chandlerfamily.org.uk
http://www.chandler.u-net.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
