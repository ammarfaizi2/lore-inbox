Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263150AbTCLLIk>; Wed, 12 Mar 2003 06:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263148AbTCLLIk>; Wed, 12 Mar 2003 06:08:40 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2308 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263152AbTCLLIj>;
	Wed, 12 Mar 2003 06:08:39 -0500
Date: Tue, 11 Mar 2003 11:47:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.5.64: i2c-proc kills machine at boot
Message-ID: <20030311104721.GA401@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

If I turn #ifdef DEBUG in i2c_register_entry() into #if 1, it prints 

i2c-proc.o: NULL pointer when trying to install fill_inode fix!\n

but boots.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
