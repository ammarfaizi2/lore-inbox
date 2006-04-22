Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWDVVBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWDVVBX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 17:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWDVVBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 17:01:23 -0400
Received: from [212.33.164.1] ([212.33.164.1]:53258 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751196AbWDVVBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 17:01:22 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: [FIX] ide-io: increase timeout value to allow for slave wakeup
Date: Sat, 22 Apr 2006 23:59:21 +0300
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200604222359.21652.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


During an STR resume cycle, the ide master disk times-out when there is also 
a slave present (especially CD).  Increasing the timeout in ide-io from 
10,000 to 100,000 fixes this problem.

Andrew, do I have to send a patch or can you take care of this one-liner?

Thanks!

--
Al

