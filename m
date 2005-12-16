Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVLPOfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVLPOfe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 09:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVLPOfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 09:35:34 -0500
Received: from outmx024.isp.belgacom.be ([195.238.2.128]:27293 "EHLO
	outmx024.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932308AbVLPOfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 09:35:33 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.14.3] S3 and USB
Date: Fri, 16 Dec 2005 15:35:13 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512161535.13650.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I'm currently running 2.6.14.3, with S3 suspending, works like a charm.
The only things i need to disable prior to suspending (just so that I can 
re-enable them afterwards and have them working is:
- nsc_ircc (+irda_tools)
- acerhk 

USB and the like work without problems. The only problem I have is that if I 
leave USB 'on' and suspend, any activity to the USB ports causes my laptop to 
resume but it never resumes correctly. I get a black screen, no entries in 
the system logs, and I need to hold the power button to power off the 
machine. Which is very annoying since I tend to plug in my USB mouse before I 
open the screen.

Any ideas?

Jan
-- 
<RoboHak> hmm, lunch does sound like a good idea
<Knghtbrd> would taste like a good idea too
