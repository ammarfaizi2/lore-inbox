Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWGLWo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWGLWo5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWGLWo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:44:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1458 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932351AbWGLWo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:44:57 -0400
Date: Thu, 13 Jul 2006 00:44:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       roubert@df.lth.se, stern@rowland.harvard.edu,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Magic Alt-SysRq change in 2.6.18-rc1
Message-ID: <20060712224426.GK3947@elf.ucw.cz>
References: <20060711165003.25265bb7.akpm@osdl.org> <Pine.LNX.4.64.0607120213060.12900@scrub.home> <20060711173735.43e9af94.akpm@osdl.org> <Pine.LNX.4.64.0607120248050.12900@scrub.home> <20060711183647.5c5c0204.akpm@osdl.org> <Pine.LNX.4.64.0607121056170.12900@scrub.home> <44B4F88D.3060301@grupopie.com> <44B55091.2040207@grupopie.com> <d120d5000607121305g5fa5bda2v2038ecac893f4c83@mail.gmail.com> <44B575EF.1080409@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B575EF.1080409@grupopie.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Maybe we should just stop calling emulate_raw while sysrq_active is 
> active. This way, after we press Alt + SysRq, every keypress would be 
> processed as a magic sysrq and not handled by any other code until we 
> release both keys.

I guess so. Magic sysrq should be hidden from applications, even
applications using raw mode.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
