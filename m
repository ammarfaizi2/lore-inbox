Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbUKVAQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUKVAQx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 19:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbUKVAOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 19:14:45 -0500
Received: from news.suse.de ([195.135.220.2]:21656 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261880AbUKVANG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 19:13:06 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Daniel Jacobowitz <dan@debian.org>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	<419E42B3.8070901@wanadoo.fr>
	<Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
	<419E4A76.8020909@wanadoo.fr>
	<Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
	<419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
	<Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
	<20041120214915.GA6100@tesore.ph.cox.net>
	<Pine.LNX.4.58.0411211326350.11274@bigblue.dev.mdolabs.com>
	<Pine.LNX.4.58.0411211414460.20993@ppc970.osdl.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: YOW!!  Everybody out of the GENETIC POOL!
Date: Mon, 22 Nov 2004 01:13:00 +0100
In-Reply-To: <Pine.LNX.4.58.0411211414460.20993@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 21 Nov 2004 14:33:32 -0800 (PST)")
Message-ID: <je7joe91wz.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Now, try to "strace" it, or debug it with gdb, and see if you can repeat 
> the behaviour.

You'll always have hard time repeating that under strace or gdb, since a
debugger uses SIGTRAP for it's own purpose and does not pass it to the
program.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
