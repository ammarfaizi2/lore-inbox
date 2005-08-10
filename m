Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbVHJM7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbVHJM7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 08:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbVHJM7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 08:59:14 -0400
Received: from poup.poupinou.org ([195.101.94.96]:14117 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S965089AbVHJM7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 08:59:14 -0400
Date: Wed, 10 Aug 2005 14:58:48 +0200
To: Pavel Machek <pavel@ucw.cz>
Cc: Todd Poynor <tpoynor@mvista.com>, cpufreq@lists.linux.org.uk,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PowerOP 2/3: Intel Centrino support
Message-ID: <20050810125848.GM852@poupinou.org>
References: <20050809025419.GC25064@slurryseal.ddns.mvista.com> <20050810100133.GA1945@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050810100133.GA1945@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
From: Bruno Ducrot <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 12:01:33PM +0200, Pavel Machek wrote:
> Hi!
> 
> > Minimal PowerOP support for Intel Enhanced Speedstep "Centrino"
> > notebooks.  These systems run at an operating point comprised of a cpu
> > frequency and a core voltage.  The voltage could be set from the values
> > recommended in the datasheets if left unspecified (-1) in the operating
> > point, as cpufreq does.
> 
> Eh? I thought these are handled okay by cpufreq already? What is
> advantage of this over cpufreq?

ATM I'm wondering what are the pro for those patches wrt current cpufreq
infrastructure (especially cpufreq's notion of notifiers).

I still don't find a good one but I'm surely missing something obvious.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
