Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWBFUKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWBFUKB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWBFUKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:10:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24074 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932364AbWBFUKA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:10:00 -0500
Date: Fri, 3 Feb 2006 23:38:00 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk
Subject: Re: cpufreq oddness on 2.6.16-rc1-mm4
Message-ID: <20060203233759.GA2355@ucw.cz>
References: <20060203174048.GA13427@hexapodia.org> <20060203175416.GA24452@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203175416.GA24452@hexapodia.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >  git-cpufreq.patch
> > 
> > I haven't had time to debug it further, but cpufreq seems broken on my
> > Thinkpad X40 with 2.6.16-rc1-mm4.  It was working fine with
> > 2.6.15-rc5-mm3.  Automatic scaling doesn't function any more - my
> > PentiumM 1.4 GHz is fixed at 598 MHz.
> 
> Additional info - if I boot with AC connected, the CPU is fixed at 1395
> MHz.  So perhaps this is due to an ACPI change?
> 
> (I *do* see the "magic disappearing C4" that Pavel was talking about,
> but that seems to have no connection to this problem.)

magic disappearing C4 is probably feature.

-- 
Thanks, Sharp!
