Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271448AbTGQMlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 08:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271449AbTGQMlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 08:41:32 -0400
Received: from [213.13.155.14] ([213.13.155.14]:39948 "EHLO zmail.pt")
	by vger.kernel.org with ESMTP id S271448AbTGQMlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 08:41:31 -0400
Subject: SET_MODULE_OWNER
From: Ricardo Bugalho <ricardo.b@zmail.pt>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1058446580.18647.11.camel@ezquiel.nara.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 17 Jul 2003 13:56:21 +0100
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: ricardo.b@zmail.pt
X-Spam-Processed: zmail.pt, Thu, 17 Jul 2003 14:02:55 +0100
	(not processed: spam filter disabled)
X-Return-Path: ricardo.b@zmail.pt
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: ricardo.b@zmail.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
  most net device drivers have replaced MOD_INC/DEC_USE_COUNT with
SET_MODULE_OWNER but SET_MODULE_OWNER doesn't do nothing.
  Therefore, those modules (though I can only vouch for 8139too) always
report 0 use. Some people that had "modprobe -r" in their cronttab found
it quite annoying.
  I'd guess that there's a good reason for why struct net_device doesn't
have .owner field and why this happens. Can someone be so kind to point
it
out? 

-- 
	Ricardo

PS: Previous post seemed to fail, hope this one isn't a duplicate.

