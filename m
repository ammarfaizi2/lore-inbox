Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbVIATzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbVIATzY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbVIATzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:55:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2756 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030333AbVIATzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:55:14 -0400
Date: Thu, 1 Sep 2005 18:16:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vitaly Wool <vitalhome@rbcmail.ru>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       Grigory Tolstolytkin <gtolstolytkin@dev.rtsoft.ru>
Subject: Re: [PATCH] custom PM support for 8250
Message-ID: <20050901161610.GC1561@openzaurus.ucw.cz>
References: <43159011.3060206@rbcmail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43159011.3060206@rbcmail.ru>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Greetings,
> please find the patch that allows passing the pointer to custom power 
> management routine (via platform_device) to 8250 serial driver.
> Please note that the interface to the outer world (i. e. exported 
> functions) remained the same.

No. Current state needs to be pm_message_t, not int.
				Pavel


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

