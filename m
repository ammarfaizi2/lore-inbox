Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265960AbSKBMqR>; Sat, 2 Nov 2002 07:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265950AbSKBMpZ>; Sat, 2 Nov 2002 07:45:25 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2564 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265955AbSKBMpD>;
	Sat, 2 Nov 2002 07:45:03 -0500
Date: Fri, 1 Nov 2002 22:12:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: make clean broken in 2.5.45
Message-ID: <20021101211207.GA238@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

make clean; time make bzImage took one minute for me. That's *not*
right. rm `find . -name "*.o"` resulted in >5 minutes compilation
time.

							Pavel
-- 
When do you have heart between your knees?
