Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbTJWUJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 16:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbTJWUIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 16:08:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11975 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261782AbTJWUIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 16:08:14 -0400
Date: Thu, 23 Oct 2003 16:32:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dominik Brodowski <linux@brodo.de>
Cc: danielk@mrl.nyu.edu, Mattia Dongili <dongili@supereva.it>,
       linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Message-ID: <20031023143242.GH643@openzaurus.ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB60077914@scsmsx403.sc.intel.com> <1066725533.5237.3.camel@laptop.fenrus.com> <20031021095925.GB893@inferi.kami.home> <20031021101737.GA31352@wiggy.net> <20031021105234.GF893@inferi.kami.home> <Pine.SOL.4.53.0310211057060.6187@graphics.cat.nyu.edu> <20031021203215.GE26971@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031021203215.GE26971@brodo.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Yes indeed. She wants to set a cpufreq policy which suits of her needs: 
> it consists of a
> - minimum frequency	=> not too low [she's plugged in]

I just hope minimum frequency is not going to be
honoured in case of overheat.

Issue is what happens if user specifies range containing no
valid frequency. Kernel currently uses next _higher_
frequency, but going for next lower one seems to be
important (burning cpus, exploding batteries, ...)
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

