Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbUKSMMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbUKSMMe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 07:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUKSMKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 07:10:17 -0500
Received: from gprs214-244.eurotel.cz ([160.218.214.244]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261381AbUKSMJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 07:09:08 -0500
Date: Fri, 19 Nov 2004 13:08:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: 2.6.10-rc2 swsusp status & framebuffer problems
Message-ID: <20041119120856.GA1233@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

If works for me, modulo graphics problems. So if it is broken on your
machine, try finding driver that is responsible.

Graphics problems: for some reason, swsusp now eats cursor
(radeonfb)... or is it softcursor breakage? There are more problems in
framebuffer, something seems to be very wrong in palete handling. (I
set green palete by default. mutt likes to reset terminal in such way
that font goes white; with -rc2 it affects even non-current console).
 
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
