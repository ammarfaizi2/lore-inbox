Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVBHS3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVBHS3i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 13:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVBHS3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 13:29:38 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:3594 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261622AbVBHS2j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 13:28:39 -0500
Message-Id: <200502081855.j18ItFs0012685@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Ingo Molnar <mingo@elte.hu>
cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and UML? 
In-Reply-To: Your message of "Tue, 08 Feb 2005 09:39:35 +0100."
             <20050208083935.GB24669@elte.hu> 
References: <200502071835.j17IZMlS003456@ccure.user-mode-linux.org> <Pine.OSF.4.05.10502072330140.29801-200000@da410.phys.au.dk>  <20050208083935.GB24669@elte.hu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Feb 2005 13:55:15 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mingo@elte.hu said:
> Jeff, any objections against adding this change to UML at some point?

No, not at all.  I just need to understand what CONFIG_PREEMPT requires of
UML.

>From a quick read of Documentation/preempt-locking.txt, this looks like it's
implementing Rule #3 (unlock by the same task that locked), which looks fine.

				Jeff

