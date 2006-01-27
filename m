Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWA0OkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWA0OkA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWA0OkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:40:00 -0500
Received: from lila.akte.de ([213.239.211.75]:52361 "EHLO lila.akte.de")
	by vger.kernel.org with ESMTP id S1751456AbWA0Oj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:39:59 -0500
KRecCount: 1
KInfo: virscan ok
KInfo: !spam auth
Date: Fri, 27 Jan 2006 15:39:28 +0100
From: Andy Spiegl <kernelbug.Andy@spiegl.de>
To: Nick <nick@linicks.net>
Cc: John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org
Subject: modules not enabled, but loading modules!
Message-ID: <20060127143928.GB19166@spiegl.de>
Mail-Followup-To: Andy Spiegl <kernelbug.Andy@spiegl.de>,
	Nick <nick@linicks.net>, John Stoffel <john@stoffel.org>,
	linux-kernel@vger.kernel.org
References: <20060124121542.GB13646@spiegl.de> <17366.13811.386903.438419@smtp.charter.net> <20060124142151.GA3538@spiegl.de> <7c3341450601240715n3af86efbl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c3341450601240715n3af86efbl@mail.gmail.com>
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

> There is something funny with your build - from the syslog:
> 
> Jan 13 11:51:43 condor kernel: Symbols match kernel version 2.6.15.
> Jan 13 11:51:43 condor kernel: No module symbols loaded - kernel
> modules not enabled.
> 
> So how can you use modules?

Good question!  I had never noticed this strange line!
But loading (and unloading) modules works just fine.

Example further down:
 Jan 13 11:51:44 condor kernel: ISDN subsystem Rev: 1.1.2.3/1.1.2.3/1.1.2.2/1.1.2.3/1.1.2.2/1.1.2.2 loaded
and
 Jan 13 11:51:44 condor kernel: Linux video capture interface: v1.00
 Jan 13 11:51:44 condor kernel: saa7146: register extension 'budget_av'.

Yesterday I tried with 2.6.15.1 - same behaviour!
Very strange!  How can that be?

Thanks for pointing this out,
 Andy.

-- 
 Fotos: francisco.spiegl.de            o      _     _         _              
 Infos: peru.spiegl.de       __o      /\_   _ \\o  (_)\__/o  (_)         -o) 
 Andy, Heidi, Francisco    _`\<,_    _>(_) (_)/<_    \_| \   _|/' \/      /\\
 heidi.und.andy@spiegl.de (_)/ (_)  (_)        (_)   (_)    (_)'  _\o_   _\_v
 ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
 Banging your head against a wall uses 150 calories an hour.
