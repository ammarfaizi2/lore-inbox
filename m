Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbUCDQdu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 11:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUCDQdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 11:33:49 -0500
Received: from c10053.upc-c.chello.nl ([212.187.10.53]:14508 "EHLO
	smurver.fakenet") by vger.kernel.org with ESMTP id S262001AbUCDQds
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 11:33:48 -0500
Message-ID: <40475A63.6050904@vanE.nl>
Date: Thu, 04 Mar 2004 17:33:39 +0100
From: Erik van Engelen <Info@vanE.nl>
User-Agent: Mozilla Thunderbird 0.5b (Windows/20040301)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: steve.cameron@hp.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: cpqarray not on EISA in 2.6 kernels??
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a compaq smart2 array on EISA with 2 disk from which i boot. This 
worked fine om the 2.4 kernel. Now i need to run a 2.6 kernel but i got 
a kernel panic.

I looked at the driver(2.4.5) in the 2.6 kernel source and found out it 
was a call to the pci_dev->dma_mask that caused the problem. (line 397)

Is this driver supporting EISA bus? If not is this support comming back?

Greetings
Erik van Engelen


