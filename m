Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269002AbRHYSWJ>; Sat, 25 Aug 2001 14:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270101AbRHYSV7>; Sat, 25 Aug 2001 14:21:59 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:5042 "EHLO snfc21.pbi.net")
	by vger.kernel.org with ESMTP id <S269002AbRHYSVv>;
	Sat, 25 Aug 2001 14:21:51 -0400
Date: Sat, 25 Aug 2001 11:22:09 -0700
From: Hugh Caley <hcaley@loomer.com>
Subject: Remounting problem on Dell 6450 and 2.4.4
To: linux-kernel@vger.kernel.org
Message-id: <0GIM00H4CZ0VA0@mta5.snfc21.pbi.net>
MIME-version: 1.0
X-Mailer: Apple Mail (2.388)
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope this is the correct forum for this.  I am trying to build a 2.4.4 
kernel (don't ask, EMC requires it) for a Dell 6450 with a megaraid 
controller.  I have tried it both building the megaraid and aic7xxx 
drivers as modules and non-modular.

In either case, the machine boots, it finds the disks, and then somehow 
the root filesystem is never remounted read-write and so all the system 
services fail to start up.

Anyone seen anything like this?

Dell 6450, RedHat 7.2 (with lots of updates), 2.4.4 source from 
ftp.us.kernel.org.

Hugh
