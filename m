Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUC2Mch (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbUC2Mc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:32:27 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:44943 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262905AbUC2MaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:30:15 -0500
Date: Mon, 29 Mar 2004 13:36:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040329113641.GE1453@openzaurus.ucw.cz>
References: <4066021A.20308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4066021A.20308@pobox.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Things seem to be looking pretty good, so it's now time to turn on 
> lba48-sized transfers.  Most SATA disks will be lba48 anyway, even 
> the ones smaller than 137GB, for this and other reasons.
> 
> With this simple patch, the max request size goes from 128K to 
> 32MB... so you can imagine this will definitely help performance.  
> Throughput goes up.  Interrupts go down.  Fun for the whole family.

32MB is one second if everything goes okay... That will be horrible for latency, right?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

