Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSFXUFd>; Mon, 24 Jun 2002 16:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315222AbSFXUFc>; Mon, 24 Jun 2002 16:05:32 -0400
Received: from NODE1.HOSTING-NETWORK.COM ([66.186.193.1]:12 "HELO
	hosting-network.com") by vger.kernel.org with SMTP
	id <S315214AbSFXUFb>; Mon, 24 Jun 2002 16:05:31 -0400
Subject: 2.4.19-rc1 make modules_install: cp warning source file  `foo.o'
	specified more than once
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 24 Jun 2002 12:59:08 -0700
Message-Id: <1024948749.2225.132.camel@shire.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During make modules_install I got dozens of these warnings,
here is a short example.

cp: warning: source file `ad1848.o' specified more than once
cp: warning: source file `ad1848.o' specified more than once
cp: warning: source file `ad1848.o' specified more than once
cp: warning: source file `uart401.o' specified more than once
cp: warning: source file `ad1848.o' specified more than once
cp: warning: source file `mpu401.o' specified more than once
cp: warning: source file `ad1848.o' specified more than once
cp: warning: source file `sb_lib.o' specified more than once
cp: warning: source file `uart401.o' specified more than once
cp: warning: source file `cs4232.o' specified more than once
cp: warning: source file `uart401.o' specified more than once

Torrey Hoffman
thoffman@arnor.net


