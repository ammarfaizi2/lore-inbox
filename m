Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbVF2HBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbVF2HBN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVF2HBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:01:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15747 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262450AbVF2HBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:01:11 -0400
Date: Wed, 29 Jun 2005 09:00:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050629070058.GA15987@elte.hu>
References: <200506281927.43959.annabellesgarden@yahoo.de> <20050628202147.GA30862@elte.hu> <20050628203017.GA371@elte.hu> <200506290151.53675.annabellesgarden@yahoo.de> <20050629063439.GB12536@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629063439.GB12536@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> [...] but i think i'm going to revert that, it's causing too many 
> problems all around.

reverted it and this enabled the removal of the extra ->disable() you 
noticed - this should further speed up the IOAPIC code. These changes 
are in the -50-34 kernel i just uploaded.

	Ingo
