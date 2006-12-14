Return-Path: <linux-kernel-owner+w=401wt.eu-S1750704AbWLNW4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWLNW4P (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 17:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWLNW4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 17:56:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46764 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750704AbWLNW4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 17:56:14 -0500
X-Greylist: delayed 1123 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 17:56:10 EST
Date: Thu, 14 Dec 2006 23:37:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: hpa@zytor.com, Andrew Morton <akpm@osdl.org>
Subject: kernel.org lies about latest -mm kernel
Message-ID: <20061214223718.GA3816@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

pavel@amd:/data/pavel$ finger @www.kernel.org
[zeus-pub.kernel.org]
...
The latest -mm patch to the stable Linux kernels is: 2.6.19-rc6-mm2
pavel@amd:/data/pavel$ head /data/l/linux-mm/Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 19
EXTRAVERSION = -mm1
...
pavel@amd:/data/pavel$

AFAICT 2.6.19-mm1 is newer than 2.6.19-rc6-mm2, but kernel.org does
not understand that.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
