Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281823AbRLBV1H>; Sun, 2 Dec 2001 16:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281811AbRLBV05>; Sun, 2 Dec 2001 16:26:57 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:46720 "EHLO
	Elf.ucw.cz") by vger.kernel.org with ESMTP id <S281797AbRLBVYt>;
	Sun, 2 Dec 2001 16:24:49 -0500
Date: Sun, 2 Dec 2001 21:52:32 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: braam@clusterfilesystem.com
Subject: ENTRY macro (coda maintainers please listen)
Message-ID: <20011202215232.A1751@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

linux/linkage.h includes macro "ENTRY(a)", while linux/coda_linux
includes ... macro "ENTRY".

It would be good to rename one of them (they are probably not needed
in one module, anyway, that's not clean)...

Oh and there's no entry for CODA in MAINTAINERS file. You probably
want to fix that.
							Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
