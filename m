Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292658AbSBZSbl>; Tue, 26 Feb 2002 13:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292420AbSBZSbe>; Tue, 26 Feb 2002 13:31:34 -0500
Received: from [216.174.202.133] ([216.174.202.133]:50955 "EHLO
	ark.dev.insynq.com") by vger.kernel.org with ESMTP
	id <S292658AbSBZSaN>; Tue, 26 Feb 2002 13:30:13 -0500
To: linux-kernel@vger.kernel.org, nkirsch@insynq.com
Subject: Reproducible freeze on 2.4.18
Message-Id: <E16fmKH-0005Ow-00@ark.dev.insynq.com>
From: Nicholas Kirsch <nkirsch@insynq.com>
Date: Tue, 26 Feb 2002 10:27:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Help! Using 2.4.18 (and verified as far back as .9) - I am getting a process freeze when an application does an fsync. The MagicSysrq sync never completes, so I am unsure as to whether this is a deadlock or not. Dual PIII, I2O RAID controller, 2 GB MEM, ext2 filesystem. The problem is reproducible. I am going to try single CPU with no HIGHMEM. 
Any advice would be greatly appreciate. Please CC to nkirsch@insynq.com. 
Thanks!
