Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUIFHgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUIFHgh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 03:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267248AbUIFHgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 03:36:37 -0400
Received: from fafner.doit.wisc.edu ([144.92.197.155]:28886 "EHLO
	smtp6.wiscmail.wisc.edu") by vger.kernel.org with ESMTP
	id S266611AbUIFHgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 03:36:17 -0400
Date: Mon, 06 Sep 2004 07:36:10 +0000
From: John Lenz <lenz@cs.wisc.edu>
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
In-reply-to: <20040904214111.GA19601@atrey.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: John Lenz <lenz@cs.wisc.edu>, Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       linux-kernel@vger.kernel.org, Kalin KOZHUHAROV <kalin@thinrope.net>
Message-id: <1094456170l.4240l.1l@hydra>
MIME-version: 1.0
X-Mailer: Balsa 2.2.4
Content-type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Spam-Score: 
X-Spam-Report: IsSpam=no, Probability=7%, Hits=__CD 0, __CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0,
 __SANE_MSGID 0, __bl.spamcop.net_TIMEOUT
X-Spam-PmxInfo: Server=avs-3, Version=4.7.0.111621, Antispam-Engine: 2.0.0.0,
 Antispam-Data: 2004.9.5.0, SenderIP=146.151.41.63
References: <1094157190l.4235l.2l@hydra> <ch8tdd$1uf$1@sea.gmane.org>
 <20040903120634.GK6985@lug-owl.de> <1094237243l.7429l.1l@hydra>
 <20040903232507.A8810@flint.arm.linux.org.uk>
 <20040904111202.GB28074@atrey.karlin.mff.cuni.cz>
 <20040904215333.B29410@flint.arm.linux.org.uk>
 <20040904214111.GA19601@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/04 16:41:11, Pavel Machek wrote:
> > What next?  One sysfs node plus attributes per GPIO line?  How about
> > we do one sysfs node per virtual memory bit so people can control
> > anything in their system on a bit granularity without needing mmap
> > or any other interfaces?  When does this madness stop?
> 
> GPIO lines are obviously system specific, I guess they could go to
> /proc or be controlled via ioctl()... But that was attempt at
> universal LED interface, right?

Yep.  As well, the GPIO interface proposed by Robert Schwebel should be  
kept seperate... I don't see a reason or anything useful from unifying  
them.

John



