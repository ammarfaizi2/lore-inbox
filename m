Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVIEO7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVIEO7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 10:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVIEO7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 10:59:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19936 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751295AbVIEO7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 10:59:04 -0400
Date: Mon, 5 Sep 2005 16:52:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Joerg Sommrey <jo@sommrey.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] amd76x_pm: C2 powersaving for AMD K7
Message-ID: <20050905145240.GB2142@openzaurus.ucw.cz>
References: <20050901201434.GA8728@sommrey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901201434.GA8728@sommrey.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> +NOTE: Currently there's a bug somewhere where the reading the
> +      P_LVL2 for the first time causes the system to sleep instead of 
> +      idling. This means that you need to hit the power button once to
> +      wake the system after loading the module for the first time after
> +      reboot. After that the system idles as supposed.
> +      (Only observed on Tony's system.)

Could you fix this before merge?

Also remove changelog from .c file.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

