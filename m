Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266458AbUAIJov (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 04:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266461AbUAIJov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 04:44:51 -0500
Received: from math.ut.ee ([193.40.5.125]:49066 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S266458AbUAIJop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 04:44:45 -0500
Date: Fri, 9 Jan 2004 11:44:41 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Qlogic ISP 1280/12160 did not call scsi_unregister
Message-ID: <Pine.GSO.4.44.0401091143180.366-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried the qla1280 driver on 2.6.1-rc3 (x86 32-bit PCI). It worked
well, even under stress. But on rmmod I got the following error:

Qlogic ISP 1280/12160 did not call scsi_unregister
Call Trace:
 [<d8b064b2>] exit_this_scsi_driver+0xd2/0x115 [qla1280]
 [<c01340bc>] sys_delete_module+0x11c/0x140
 [<c0149bf4>] sys_munmap+0x44/0x70
 [<c01093d9>] sysenter_past_esp+0x52/0x71

-- 
Meelis Roos (mroos@linux.ee)

