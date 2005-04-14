Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVDNTZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVDNTZh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 15:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVDNTZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 15:25:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27576 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261600AbVDNTZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 15:25:32 -0400
Date: Thu, 14 Apr 2005 21:21:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ali Akcaagac <aliakc@web.de>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [BUG] 2.6.12-rc1/rc2 mouse0 became mouse1
Message-ID: <20050414192142.GA2728@openzaurus.ucw.cz>
References: <1112961492.1618.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112961492.1618.3.camel@localhost>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This doesn't sound right to me. After upgrading from 2.6.11.5/6 to
> 2.6.12-rc1/rc2 I detected that my mouse didn't operate anymore when
> loading up XOrg, I realized that /dev/input/mouse0 (which worked for
> years) had to be changed to /dev/input/mouse1. Anyone care to explain
> why this had to be changed or what the intention behind this was ?
> 

This is a bug where we assume keyboard has scrollwheel, and therefore
we pretend its keyboard and a bit of mouse?

Did we stop generating zero mouse movements during typing?
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

