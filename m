Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbVA0SqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbVA0SqW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbVA0SqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:46:22 -0500
Received: from gprs213-80.eurotel.cz ([160.218.213.80]:128 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262692AbVA0SqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:46:15 -0500
Date: Thu, 27 Jan 2005 19:43:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Applications segfault on evo n620c with 2.6.10
Message-ID: <20050127184334.GA1368@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It happened for 3rd in a week now...

When problem happens, processes start to segfault, usually right
during startup. Programs that were loaded prior to problem usualy
works, and can be restarted. I also seen sendmail exec failing with
"no such file or directory" when it clearly was there. Reboot corrects
things, and filesystem (ext3) is not damaged.

Unfortunately I do not know how to reproduce it. I tried
parallel-building kernels for few hours and that worked okay. Swsusp
is not involved (but usb, bluetooth, acpi and sound may be).

Does anyone else see something similar?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
