Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292901AbSBVSbT>; Fri, 22 Feb 2002 13:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292902AbSBVSbA>; Fri, 22 Feb 2002 13:31:00 -0500
Received: from ark.dev.insynq.com ([216.174.202.133]:9997 "EHLO
	ark.dev.insynq.com") by vger.kernel.org with ESMTP
	id <S292901AbSBVSaj>; Fri, 22 Feb 2002 13:30:39 -0500
To: linux-kernel@vger.kernel.org
Subject: Process locks using Intel RAID SRCU3-1 (I2O)
Message-Id: <E16eKQx-0004Se-00@ark.dev.insynq.com>
From: Nicholas Kirsch <nkirsch@insynq.com>
Date: Fri, 22 Feb 2002 10:28:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.4.18-rc2 with an Intel RAID SRCU-1 controller (I2O) my processes lock after writing X data to the array. Not every process locks, but I can consistently reproduce the problem with dd. The kernel continues running just fine. I have tried SMP and non, the result is the same. 

If anyone has any experience or can offer suggestions, please CC me.

Thanks.

Nick <nkirsch at insynq com>
