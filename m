Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263821AbTLECPr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 21:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTLECPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 21:15:47 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:2290 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263821AbTLECPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 21:15:46 -0500
Date: Thu, 4 Dec 2003 21:15:22 -0500
From: "Rahsheen Porter Sr." <microrahsheen@comcast.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: HPT366 ate my IDE controllers
Message-Id: <20031204211522.01e89897.microrahsheen@comcast.net>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I boot 2.6.0test11 on my Abit BP6, it *only* sees the HPT366
controllers. The other 2 controllers built in to the mobo don't show
up at all. All I see is what's plugged into the 2 HPT366 controllers.

So my root partition, which resides on /dev/hde1 with 2.4.20, becomes
/dev/hda1. And my extra partitions that were on /dev/hdg are on
/dev/hdc. This wouldn't be a problem accept that what was on /dev/hda
and hdc are now gone. 

What would cause the kernel to totally ignore the built in controllers?

-- 
Rahsheen Porter	<microrahsheen@comcast.net>
