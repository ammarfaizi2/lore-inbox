Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318277AbSIKCE3>; Tue, 10 Sep 2002 22:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318278AbSIKCE3>; Tue, 10 Sep 2002 22:04:29 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:32150 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318277AbSIKCE2>;
	Tue, 10 Sep 2002 22:04:28 -0400
Message-Id: <200209110209.g8B298D00202@eng4.beaverton.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.34 gendisk changes
Date: Tue, 10 Sep 2002 19:09:07 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would seem that in 2.5.34 gendisk->part[0] no longer refers to the
whole disk, but instead refers to the first partition.  Is this
correct? There isn't a struct hd_struct that refers to the whole disk
anymore?

I'm working on porting forward the sard patch for disk statistics, so I
want to make sure this is the intent and not an off-by-one bug. Other
code, though, suggests it's intentional.

Rick
