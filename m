Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267618AbTBFUUr>; Thu, 6 Feb 2003 15:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267619AbTBFUUr>; Thu, 6 Feb 2003 15:20:47 -0500
Received: from mail0.lsil.com ([147.145.40.20]:23039 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id <S267618AbTBFUUq>;
	Thu, 6 Feb 2003 15:20:46 -0500
Message-Id: <EB1DF7EA0D32D611B79C0002A51363F1AC9E08@exw-ks.ks.lsil.com>
From: "Liu, Yanqing" <yaliu@lsil.com>
To: linux-kernel@vger.kernel.org
Subject: Driver Loading Order at Boot Time
Date: Thu, 6 Feb 2003 14:29:48 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="gb2312"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   I am new to Line and have some questions about how Linux system resolves
module dependency. Now I need to control the loading order of a driver so
that at system boot up time, it can be loaded after the sd and sg driver,
but before the low level HBA drivers (like qlogic HBA driver). I know that
there's module.conf that specifies module parameters, but I don't know which
parameter we can use to specify to control the loading order at boot up
time. Anyone has any ideas about that? Thanks.

Yanqing Liu
LSI Logic Storage Systems, Inc.
Phone: (512)794-3734
