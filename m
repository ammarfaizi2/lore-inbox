Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVBFMQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVBFMQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 07:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVBFMQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 07:16:27 -0500
Received: from gprs214-130.eurotel.cz ([160.218.214.130]:52911 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261235AbVBFMPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 07:15:16 -0500
Date: Sun, 6 Feb 2005 13:15:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Dynamic tick, version 050127-1
Message-ID: <20050206121504.GB1151@elf.ucw.cz>
References: <20050201212542.GA3691@openzaurus.ucw.cz> <20050201230357.GH14274@atomide.com> <20050202141105.GA1316@elf.ucw.cz> <20050203030359.GL13984@atomide.com> <20050203105647.GA1369@elf.ucw.cz> <20050203164331.GE14325@atomide.com> <20050204051929.GO14325@atomide.com> <20050205230017.GA1070@elf.ucw.cz> <20050206023344.GA15853@atomide.com> <20050206035417.GB15853@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206035417.GB15853@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +extern void disable_pit_tick(void);
> +extern void reprogram_pit_tick(int jiffies_to_skip);
> +extern void reprogram_apic_timer(unsigned int count);
> +extern void reprogram_pit_tick(int jiffies_to_skip);

reprogram_pit_tick is here twice; but perhaps this should be moved to
some kind of header file.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
