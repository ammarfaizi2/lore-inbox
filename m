Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267055AbUBMQ2Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267098AbUBMQ2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:28:25 -0500
Received: from ddc.ilcddc.com ([12.35.229.4]:51466 "EHLO ddcnyntd.ddc-ny.com")
	by vger.kernel.org with ESMTP id S267055AbUBMQ2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:28:13 -0500
Message-ID: <89760D3F308BD41183B000508BAFAC4104B16F6F@DDCNYNTD>
From: RANDAZZO@ddc-web.com
To: linux-kernel@vger.kernel.org
Subject: spinlocks dont work
Date: Fri, 13 Feb 2004 11:27:23 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my uniprocessor system, I have two LKM's

driver1 takes hold of the spinlock....but does not release it...
driver2 attempts to take hold, and is allowed!!!!

how come spin locks don't work?????

how can I restrict access (to hardware) to only one driver at a time???

should I use semaphores,  etc...


 
"This message may contain company proprietary information. If you are not
the intended recipient, any disclosure, copying, distribution or reliance on
the contents of this message is prohibited. If you received this message in
error, please delete and notify me."

