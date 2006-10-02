Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965421AbWJBVmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965421AbWJBVmW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965419AbWJBVmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:42:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64157 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965421AbWJBVmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:42:21 -0400
Date: Mon, 2 Oct 2006 23:42:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>
Subject: brightness no longer adjustable in 2.6.18-git
Message-ID: <20061002214212.GA2242@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Something changed (in linux acpi code?) and brightness on thinkpad x60
can no longer be adjusted by fn-home/end keys.

/proc/acpi/ibm still works...

root@amd:/proc/acpi/ibm# echo level 0 > brightness
root@amd:/proc/acpi/ibm# echo level 7 > brightness

(This is not from clean boot, I did suspend to ram and some
powersaving stuff, so if it happens on your machine, too, let me
know.) It worked okay in 2.6.18 (even with suspends/etc).

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
