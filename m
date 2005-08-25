Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbVHZTmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbVHZTmb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbVHZTmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:42:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41344 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030232AbVHZTmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:42:05 -0400
Date: Thu, 25 Aug 2005 14:00:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: suspicious behaviour in pcwd driver.
Message-ID: <20050825120054.GA443@openzaurus.ucw.cz>
References: <20050822183006.GB27344@redhat.com> <20050822200144.GG27344@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822200144.GG27344@redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


>  > 2. that printk will never hit the logs, so the admin will just find
>  > a powered off box with no idea what happened.
>  > Should we at least sync block devices before doing the power off ?
> 
> AFAICS, this is still a problem with kernel_power_off() though ?
> 

Look at how acpi does this; we probably want to trigger clean shutdown.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

