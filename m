Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbTBBWWV>; Sun, 2 Feb 2003 17:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbTBBWWV>; Sun, 2 Feb 2003 17:22:21 -0500
Received: from [195.39.17.254] ([195.39.17.254]:6404 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265675AbTBBWWU>;
	Sun, 2 Feb 2003 17:22:20 -0500
Date: Sun, 2 Feb 2003 23:30:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Compactflash cards dying?
Message-ID: <20030202223009.GA344@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I had compactflash from Apacer (256MB), and it started corrupting data
in few months, eventually becoming useless and being given back for
repair. They gave me another one and it is just starting to corrupt
data.

First time I repartitioned it; now I only did mke2fs, and data
corruption can be seen by something as simple as

cat /mnt/cf/mp3/* > /mnt/cf/delme; md5sum /mnt/cf/delme.

[Fails 1 in 5 tries].

Anyone seen something similar? Are there some known-good
compactflash-es?

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
