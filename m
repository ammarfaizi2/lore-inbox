Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262779AbVBBXpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbVBBXpD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 18:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbVBBXor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:44:47 -0500
Received: from gprs215-95.eurotel.cz ([160.218.215.95]:26755 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262477AbVBBXkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:40:12 -0500
Date: Thu, 3 Feb 2005 00:38:19 +0100
From: Pavel Machek <pavel@suse.cz>
To: Peter =?iso-8859-1?Q?M=FCnster?= <pmlists@free.fr>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       axboe@suse.de, benh@kernel.crashing.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [ACPI] [Patch] keep ide disk sleeping when resuming
Message-ID: <20050202233819.GA779@elf.ucw.cz>
References: <Pine.LNX.4.58.0502022006030.4130@gaston.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502022006030.4130@gaston.free.fr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I need this patch (against linux-2.6.11-rc2), to keep ide disk sleeping,
> when resuming from ACPI S1.
> 
> In fact, it's just removing a patch from 22 Jun 2004 by Jens Axboe. He has
> told me, that "We can probably kill the patch completely".
> So, this is what I'm doing now.

Are you sure it does not affect S3/S4 in any way? You currently can't
easily tell S1 from S3/S4... Please wait with this one. When
pm_message_t is introduced (post 2.6.11), we can fix it properly.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
