Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261576AbREXRhf>; Thu, 24 May 2001 13:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbREXRhZ>; Thu, 24 May 2001 13:37:25 -0400
Received: from [193.126.240.190] ([193.126.240.190]:10684 "EHLO
	mcmmta02.iol.pt") by vger.kernel.org with ESMTP id <S261564AbREXRhM>;
	Thu, 24 May 2001 13:37:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Pedro Miguel Semeano <skinbits@ccjfaro.org>
To: linux-kernel@vger.kernel.org
Subject: Newbie question
Date: Thu, 24 May 2001 18:29:58 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01052418295800.00624@Tuphir>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm doing a project in linux, and I'm changing the driver of sym53c8xx (a 
SCSI board) to support Target mode. 

To receive data, we need 2 interrupts. One is for initializing all of the 
structures needed, and the second to send the data to the SCSI layer. What 
happens is that bettwen that two interrupts i can't start sending data, but 
in some cases that happen, and is beyond my control. To start sending data I 
set a bit in a certain register of the chip. 

What i would like to know is how can i to a kind of lock so that I set a 
variable in the first interrupt, and unset it in the second. If the SCSI 
layer trys to send data, I whant to stop before I set the bit of the chip. 
But I don't know how...

Can anybody tel me how to do it?

Pedro Semeano
