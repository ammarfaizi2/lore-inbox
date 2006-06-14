Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWFNCZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWFNCZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 22:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWFNCZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 22:25:30 -0400
Received: from 066-241-084-054.bus.ashlandfiber.net ([66.241.84.54]:29384 "EHLO
	bigred.russwhit.org") by vger.kernel.org with ESMTP id S964931AbWFNCZ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 22:25:29 -0400
Date: Tue, 13 Jun 2006 19:23:30 -0700 (PDT)
From: Russell Whitaker <russ@ashlandhome.net>
X-X-Sender: russ@bigred.russwhit.org
To: linux-kernel@vger.kernel.org
Subject: 2.6.16.19 + gcc-4.1.1
Message-ID: <Pine.LNX.4.63.0606131906230.2368@bigred.russwhit.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

First, I did this:
   made kernel with cpu=486, gcc-3.3.6
   worked fine.

Next, changed cpu to k6, all else same.
   worked fine.

Then, after mrproper, rebuilt with gcc-4.1.1, no other changes.
   compiles ok, installs ok. But, when attempting to load a module, get
   the following message:  version magic '2.6.16.19via K6 gcc-4.1',
   should be '2.6.16.19via 486 gcc-3.3'

How should I fix it?
Please cc personally.

   Thanks,
     russ
