Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVAUQaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVAUQaX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 11:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVAUQaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 11:30:23 -0500
Received: from bluebox.CS.Princeton.EDU ([128.112.136.38]:43405 "EHLO
	bluebox.CS.Princeton.EDU") by vger.kernel.org with ESMTP
	id S262414AbVAUQaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 11:30:16 -0500
From: "Marc E. Fiuczynski" <mef@CS.Princeton.EDU>
To: "Jens Axboe" <axboe@suse.de>, <Valdis.Kletnieks@vt.edu>
Cc: "Peter Williams" <pwil3058@bigpond.net.au>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Con Kolivas" <kernel@kolivas.org>, "Chris Han" <xiphux@gmail.com>
Subject: RE: [ANNOUNCE][RFC] plugsched-2.0 patches ...
Date: Fri, 21 Jan 2005 11:29:55 -0500
Message-ID: <NIBBJLJFDHPDIBEEKKLPIEDNDIAA.mef@cs.princeton.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20050121141136.GG2790@suse.de>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paraphrasing Jens Axboe:
> I don't think you can compare [plugsched with the plugio framework].
> Yes they are both schedulers, but that's about where the 'similarity'
> stops. The CPU scheduler must be really fast, overhead must be kept
> to a minimum. For a disk scheduler, we can affort to burn cpu cycles
> to increase the io performance. The extra abstraction required to
> fully modularize the cpu scheduler would come at a non-zero cost as
> well, but I bet it would have a larger impact there. I doubt you
> could measure the difference in the disk scheduler.

Modularization usually is done through a level of indirection (function
pointers).  I have a can of "indirection be gone" almost ready to spray over
the plugsched framework that would reduce the overhead to zero at runtime.
I'd be happy to finish that work if it makes it more palpable to integrate a
plugsched framework into the kernel?

Marc

