Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVGWMez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVGWMez (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 08:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVGWMez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 08:34:55 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:57025 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261569AbVGWMey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 08:34:54 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.12.3] dyntick 050610-1 breaks makes S3 suspend
Date: Sat, 23 Jul 2005 14:35:04 +0200
User-Agent: KMail/1.8.1
Cc: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507231435.05015.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently tried out dyntick 050610-1 against 2.6.12.3, works great, it 
actually makes a noticeable difference on my laptop's battery life. I don't 
have hard numbers, lets just say that instead of the usual ~3 hours i get out 
of it, i was ~4 before it started nagging, usual use pattern at work.

The only gripe I have with it that it stops S3 from working. If the patch is 
compiled in the kernel, it makes S3 suspend correctly, but resuming goes into 
a solid hang (nothing get's it back alive, have to keep the powerbutton for 
~5 secs to shutdown the system)

Anything I could test? The logs don't give anything useful..

Thanks,

Jan
-- 
Yow!  I'm having a quadrophonic sensation of two winos alone in a steel mill!
