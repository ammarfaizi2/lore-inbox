Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262616AbRFGRh5>; Thu, 7 Jun 2001 13:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262617AbRFGRhq>; Thu, 7 Jun 2001 13:37:46 -0400
Received: from zeus.fb.org ([198.80.61.27]:43275 "EHLO zeus.fb.org")
	by vger.kernel.org with ESMTP id <S262616AbRFGRhi>;
	Thu, 7 Jun 2001 13:37:38 -0400
Message-ID: <2F5E5F88C53DD211BB0E00A0C9B57191015222DE@fb00.fb.com>
From: Kelly Martin <kellym@fb00.fb.org>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: random failures with megaraid driver on 2.4.4 SMP
Date: Thu, 7 Jun 2001 12:40:03 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an HP Netserver 1000r (dual Pentium 3) with a HP NetRAID-1M card
running Linux 2.4.4 with the megaraid driver included in 2.4.4 that has
twice now experienced kernel panics related to file system damage which
appear to be caused by the megaraid driver going mad and scribbling randomly
on the drive.  We have using this same driver with 2.2.x kernels on other
uniprocessor machines with the same NetRAID card for over a year with no
failures, so it seems likely that this is either a 2.4.x problem or an SMP
problem with this driver.  

This machine is slated to become a production system and I do not have a
similiarly-configured spare machine, so I am not going to pursue this
problem at this time.  This card works fine under 2.2.x so we are going to
use 2.2.19 on this machine for now.  However, doing so makes our second
processor little more than a space heater.  I have not tried using other
versions of the megaraid driver or kernels other than 2.4.4; I simply cannot
spare the time right now.

I am not subscribed to the mailing list; please cc: replies.

Kelly Martin
American Farm Bureau Federation
kellym@fb.org

