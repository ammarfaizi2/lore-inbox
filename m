Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbSKVMFV>; Fri, 22 Nov 2002 07:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbSKVMFV>; Fri, 22 Nov 2002 07:05:21 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:63886 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264644AbSKVMFU>; Fri, 22 Nov 2002 07:05:20 -0500
Message-Id: <4.3.2.7.2.20021122122413.00b54df0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 22 Nov 2002 13:12:43 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: P4 compile options
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quite so, Dave.
I just wondered what that might do with 2.4.xx.
Following is based on 2.4.xx.
In the next few days, I'll be setting up an Informix application on my P4 box.
This is a read-only app.
Bumping "shmmax" and configuring Informix ensures that all the data is
held in shared memory (after the initial read).
Thereafter, this is a tight semaphore/shared memory (also 
user-program/Informix)
reaction with the kernel.
(This really gets the processor fan(s) going!)
This app takes ca. 80 mins on a dual P3 (1 GHz) and (Hmm) 90 mins on a 
single P3 (1 GHz)
(Before anybody comments, all boxes (mine as well) have Adaptec 
U160/controller/disks)
So, Let's just wait and see !

Margit 

