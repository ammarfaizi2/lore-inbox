Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVBFRLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVBFRLh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVBFRKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:10:00 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:7552 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261223AbVBFRIk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:08:40 -0500
Date: Sun, 6 Feb 2005 09:08:45 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Dynamic tick, version 050127-1
Message-ID: <20050206170845.GB13936@atomide.com>
References: <20050201230357.GH14274@atomide.com> <20050202141105.GA1316@elf.ucw.cz> <20050203030359.GL13984@atomide.com> <20050203105647.GA1369@elf.ucw.cz> <20050203164331.GE14325@atomide.com> <20050204051929.GO14325@atomide.com> <20050205230017.GA1070@elf.ucw.cz> <20050206023344.GA15853@atomide.com> <20050206035417.GB15853@atomide.com> <20050206121504.GB1151@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206121504.GB1151@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [050206 04:15]:
> Hi!
> 
> > +extern void disable_pit_tick(void);
> > +extern void reprogram_pit_tick(int jiffies_to_skip);
> > +extern void reprogram_apic_timer(unsigned int count);
> > +extern void reprogram_pit_tick(int jiffies_to_skip);
> 
> reprogram_pit_tick is here twice; but perhaps this should be moved to
> some kind of header file.

Yeah, and the function itself should be in timer_pit.c.

Tony
