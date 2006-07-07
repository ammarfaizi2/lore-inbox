Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWGGMUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWGGMUK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 08:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWGGMUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 08:20:10 -0400
Received: from tim.rpsys.net ([194.106.48.114]:15314 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932070AbWGGMUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 08:20:07 -0400
Subject: Re: [patch] sharpsl_pm refactor
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <20060707114818.GA5423@elf.ucw.cz>
References: <20060707114818.GA5423@elf.ucw.cz>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 13:16:39 +0100
Message-Id: <1152274600.5548.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 13:48 +0200, Pavel Machek wrote:
> This prepares sharpsl_pm.c for collie. Without nested if()s, #ifdefs
> can be added. 

I'm unconvinced as to why collie needs an ifdef in there and looking at
what I think you're leading to, its ugly. Perhaps you could change the 2
to a variable set by the machine instead or something, depending upon
your intention.

Rather than post these patches straight to the patch system, perhaps you
could also post them for discussion first as discussing them once
they're submitted seems wrong (and we have to remember to remove the
patch system from the cc).

> Also warn users about charging in unsuitable
> temperature.

I'm ok with that bit.

Richard

