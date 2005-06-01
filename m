Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVFBVQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVFBVQj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 17:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVFBVQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 17:16:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19879 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261321AbVFBVLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 17:11:10 -0400
Date: Wed, 1 Jun 2005 21:59:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Roy Keene <rkeene@psislidell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.6 kernel and lots of I/O
Message-ID: <20050601195922.GA589@openzaurus.ucw.cz>
References: <Pine.LNX.4.62.0505311042470.7546@hammer.psislidell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505311042470.7546@hammer.psislidell.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	Start RAID in degraded mode with remote device (nbd1)
> 	Hot-add local device (nbd0)

Stop right here. You may not use nbd over loopback.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

