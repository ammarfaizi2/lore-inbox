Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbUBEODP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 09:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUBEODP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 09:03:15 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34710 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265253AbUBEODL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 09:03:11 -0500
Date: Tue, 3 Feb 2004 14:14:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH] powernow-k8 max speed sanity check
Message-ID: <20040203131432.GE550@openzaurus.ucw.cz>
References: <20040131203512.GA21909@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131203512.GA21909@atomide.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Following is a little patch to do a sanity check on the max speed and 
> voltage values provided by the bios.
> 
> Some buggy bioses provide bad values if the cpu changes, for example, in 
> my case the bios claims the max cpu speed is 1600MHz, while it's running at
> 1800MHz. (Cheapo Emachines m6805 you know...) This could also happen on 
> machines where the cpu is upgraded.
> 
> These checks should be safe, as they only change things if the machine is
> already running at a higher speed than the bios claims.
> 

Someone should really bug them to fix their BIOS. (BTW does keyboard work
ok for you?) 
Going though ACPI solves this, and I have perhaps better
patch to hardcode right values...
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

