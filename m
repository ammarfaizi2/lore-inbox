Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318176AbSHSGXI>; Mon, 19 Aug 2002 02:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318188AbSHSGXI>; Mon, 19 Aug 2002 02:23:08 -0400
Received: from [203.197.212.137] ([203.197.212.137]:14054 "EHLO
	dns3.ggn.hcltech.com") by vger.kernel.org with ESMTP
	id <S318176AbSHSGXI>; Mon, 19 Aug 2002 02:23:08 -0400
Message-ID: <5F0021EEA434D511BE7300D0B7B6AB5303C7874E@mail2.ggn.hcltech.com>
From: "Mohamed Ghouse , Gurgaon" <MohamedG@ggn.hcltech.com>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Ingo Scheduler
Date: Mon, 19 Aug 2002 12:01:32 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all
 I am in a state of confusion.
Reason: How does Ingo Scheduler manages to schedule the entire process with
the help of expired
 queue in O(1).
I searched the net for the explaination of Ingo's Scheduler, could not find
one.

My understanding of Ingo's Scheduler

 When the process  A (from active queue) has completed its Quantum,
Scheduler moves process A to the expired queue.
& when the active queue is empty, the expired queue becomes the active queue
& the active queue becomes the 
expired 


Point of confusion 

The active queue (expired queue) has accumulated the process. It is almost
similar to the previous active queue.
How does the Introduction of the expired queue reduce the Time Complexity
from O(n) to O(1).
as my understanding goest that the scheduler needs to produce "process's
goodness", so the time complexity remains the same.

Another point of non-understanding is
Why does the scheduler need to know the scheduling class to produce
process's goodness?

TIA
-MG
