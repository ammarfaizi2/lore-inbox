Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWIGHdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWIGHdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 03:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWIGHdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 03:33:42 -0400
Received: from [213.184.169.63] ([213.184.169.63]:640 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751016AbWIGHdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 03:33:41 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-net@vger.kernel.org
Subject: [BUG] tulip:  promisc mode not restored after suspend
Date: Thu, 7 Sep 2006 10:35:18 +0300
User-Agent: KMail/1.5
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200609071035.18217.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The tulip driver is really great, but after suspending the device, the driver 
does not restore the promisc bit when resuming from S1/S3/S4.

To work around this, an ifconfig eth0 up, on the already up device, restores 
it.

Is there an easy way to fix this?


Thanks!

--
Al
