Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSFIR56>; Sun, 9 Jun 2002 13:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314241AbSFIR55>; Sun, 9 Jun 2002 13:57:57 -0400
Received: from [195.39.17.254] ([195.39.17.254]:64673 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314138AbSFIR54>;
	Sun, 9 Jun 2002 13:57:56 -0400
Date: Sat, 8 Jun 2002 23:40:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: device_suspend() / device_resume() on S1?
Message-ID: <20020608214034.GA163@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Should we do device_suspend / device_resume on acpi S1 transition?

Con: It is not needed according to specs.

Con: It is more complicated that way.

Pro: Many buggy notebooks will probably need it.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
