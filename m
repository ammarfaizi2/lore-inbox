Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUGIKCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUGIKCz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 06:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264819AbUGIKBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 06:01:06 -0400
Received: from zeus.kernel.org ([204.152.189.113]:32391 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264798AbUGIJ5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 05:57:03 -0400
Message-ID: <40916.203.197.150.195.1089366068.squirrel@203.197.150.195>
Date: Fri, 9 Jul 2004 15:11:08 +0530 (IST)
Subject: Interrupt Handling in linux
From: "Harish K Harshan" <harish@amritapuri.amrita.edu>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

 Can Interrupt handlers in linux, be interrupted by other running
processes??? to make it more clear, im developing a driver for and ADC
card, and would like to know if the CPU can or rather WILL schedule
wnother running process in the middle of the ISR, when a timer interrupt
comes in. If thats the case, then we need to use spinlocks or other
mechanisms in our ISR, right?? im new to this, so if theres something not
clear, it just just that my understanding of this topic is not very deep.

Harish.


***********************************************************************************************
 Amrita Institutions, Amritapuri, Kerala, India - 
 Sent using Amrita Mail  
 Visit http://www.amrita.edu 
