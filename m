Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317578AbSG2RwP>; Mon, 29 Jul 2002 13:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317579AbSG2RwP>; Mon, 29 Jul 2002 13:52:15 -0400
Received: from [195.39.17.254] ([195.39.17.254]:16000 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317578AbSG2RwO>;
	Mon, 29 Jul 2002 13:52:14 -0400
Date: Mon, 29 Jul 2002 19:54:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: What's wrong with ftp.cz.kernel.org?
Message-ID: <20020729175402.GA1224@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Something is wrong with ftp.cz.kernel.org. Perhaps its time to
redirect ftp.cz.kernel.org to ftp.de.kernel.org or something like that
using DNS magic until its fixed?

pavel@amd:~$ lftp ftp.cz.kernel.org
lftp ftp.cz.kernel.org:~> cd /pub/linux/kernel/v2.5
cd ok, cwd=/pub/linux/kernel/v2.5
lftp ftp.cz.kernel.org:/pub/linux/kernel/v2.5> get patch-2.5.29.bz
Interrupt
lftp ftp.cz.kernel.org:/pub/linux/kernel/v2.5> get patch-2.5.29.bz2
get: Access failed: 550 Failed to open file. (patch-2.5.29.bz2)
lftp ftp.cz.kernel.org:/pub/linux/kernel/v2.5> ls patch-2.5.28.bz2
lftp ftp.cz.kernel.org:/pub/linux/kernel/v2.5> exit
pavel@amd:~$ lftp ftp.de.kernel.org
lftp ftp.de.kernel.org:~> cd /pub/linux/kernel/v2.5
cd ok, cwd=/pub/linux/kernel/v2.5
lftp ftp.de.kernel.org:/pub/linux/kernel/v2.5> ls patch-2.5.28.bz2
-rw-r--r--   1 ftpadmin ftpadmin   675087 Jul 24 21:09
patch-2.5.28.bz2
lftp ftp.de.kernel.org:/pub/linux/kernel/v2.5> get patch-2.5.29.bz2
`patch-2.5.29.bz2' at 14480 (5%) 1014b/s eta:4m [Receiving data]

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
