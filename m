Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVBPUFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVBPUFJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 15:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVBPUFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 15:05:07 -0500
Received: from mail.charite.de ([160.45.207.131]:17373 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S261860AbVBPUEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 15:04:49 -0500
Date: Wed, 16 Feb 2005 21:04:41 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.6.10-ac12 in kjournald (journal_commit_transaction)
Message-ID: <20050216200441.GH19871@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050215145618.GP24211@charite.de> <20050216153338.GA26953@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050216153338.GA26953@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan Kara <jack@suse.cz>:

>   I guess the system is SMP...

Indeed it is. Dual Xeon with SMP.

>   Sadly a few lines in the beginning of the
> report are missing (probably scrolled off the screen)

Yes, this sucks. I rebooted with vesafb active, no I do have 50 lines :)

> but it seems similar like a several other oopses I've seen reported
> recently. Is this the first time you hit this bug?

It's actually the second time. The first time it hit the SAME box but
with kernel-2.6.10 (vanilla) after 30 days of uptime. Nobody had a
camera at hand, so I couldn't take a photo.

Any suggestions? I'm open to suggestions. One difference between the
2.6.10 and 2.6.10-ac12 was that 2.6.10 has no in-kernel irq
balancing, while in 2.6.10-ac12 I acivated that.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
