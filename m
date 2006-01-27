Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWA0VX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWA0VX1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 16:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWA0VX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 16:23:26 -0500
Received: from lila.akte.de ([213.239.211.75]:48856 "EHLO lila.akte.de")
	by vger.kernel.org with ESMTP id S1751292AbWA0VX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 16:23:26 -0500
KRecCount: 1
KInfo: virscan ok
KInfo: !spam auth
Date: Fri, 27 Jan 2006 22:23:03 +0100
From: Andy Spiegl <kernelbug.Andy@spiegl.de>
To: Benoit Boissinot <bboissin@gmail.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.15 crashes X Server after running OpenGL programs
Message-ID: <20060127212303.GM2079@spiegl.de>
Mail-Followup-To: Andy Spiegl <kernelbug.Andy@spiegl.de>,
	Benoit Boissinot <bboissin@gmail.com>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org
References: <20060124121542.GB13646@spiegl.de> <20060124142151.GA3538@spiegl.de> <40f323d00601240713x26c3a04cra46e1cd9639b12f2@mail.gmail.com> <200601241937.06679.s0348365@sms.ed.ac.uk> <20060127173215.GC19166@spiegl.de> <40f323d00601271004h7d6e3de3r1abc531cabc30b21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f323d00601271004h7d6e3de3r1abc531cabc30b21@mail.gmail.com>
X-PGP-GPG-Keys: mail -s "send pgp" auto@spiegl.de
X-Accepted-File-Formats: ASCII OpenOffice .rtf .pdf - *NO* Microsoft files please.
X-why-you-shouldnt-use-MS-LookOut: http://www.jensbenecke.de/l-oe-en.php
X-warum-man-MS-Outlook-vermeiden-sollte: http://www.jensbenecke.de/l-oe-de.php
X-Message-Flag: LookOut! You are using an insecure mail reader which can be used to spread viruses.
X-how-to-quote: http://learn.to/quote/
X-how-to-ask-questions: http://www.catb.org/~esr/faqs/smart-questions.html
X-stupid-disclaimers: http://goldmark.org/jeff/stupid-disclaimers/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You should be looking for
> "direct rendering: Yes"
> in glxinfo
> 
> You can check your X logs to see why you don't get the acceleration
> (and you have to compile drm/radeon in your kernel).
Yes, I've got drm/radeon.

But X complains:
 (WW) RADEON(0): Direct rendering is not supported when Xinerama is enabled

But I can't get Xinerama to work either with the "normal" driver.

Bad luck I guess :-(
 Andy.

-- 
 Fotos: francisco.spiegl.de            o      _     _         _              
 Infos: peru.spiegl.de       __o      /\_   _ \\o  (_)\__/o  (_)         -o) 
 Andy, Heidi, Francisco    _`\<,_    _>(_) (_)/<_    \_| \   _|/' \/      /\\
 heidi.und.andy@spiegl.de (_)/ (_)  (_)        (_)   (_)    (_)'  _\o_   _\_v
 ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
 If you keep doing what you've always done,
 you'll get what you've always gotten.
