Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289822AbSBSUVd>; Tue, 19 Feb 2002 15:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289817AbSBSUVN>; Tue, 19 Feb 2002 15:21:13 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:29450 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S289815AbSBSUVF>;
	Tue, 19 Feb 2002 15:21:05 -0500
Date: Tue, 19 Feb 2002 20:09:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: ENOTTY from ext3 code?
Message-ID: <20020219190932.GA274@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

ext3/ioctl.c:

...
	return -ENOTTY;

Does it really make sense to return "not a typewriter" from ext3
ioctl?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
