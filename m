Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270226AbTGMLgD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 07:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270227AbTGMLgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 07:36:03 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:14771 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270226AbTGMLgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 07:36:01 -0400
Date: Sun, 13 Jul 2003 13:50:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
Message-ID: <20030713115033.GA371@elf.ucw.cz>
References: <Pine.LNX.4.55.0307091929270.4625@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307091929270.4625@bigblue.dev.mcafeelabs.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I finally found a couple of hours for this and I also found a machine were
> I can run 2.5, since luck abandoned myself about this. The small page
> describe the obvious and contain the trivial patch and the latecy test app :
> 
> http://www.xmailserver.org/linux-patches/softrr.html

What happens if evil user forks 60 processes, marks them all
SCHED_SOFTRR, and tries to starve everyone else?
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
