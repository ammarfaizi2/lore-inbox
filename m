Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268215AbUHKU3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268215AbUHKU3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 16:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268219AbUHKU3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 16:29:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57529 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268215AbUHKU3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 16:29:19 -0400
Date: Wed, 11 Aug 2004 21:56:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Erik Rigtorp <erik@rigtorp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with new swsusp
Message-ID: <20040811195625.GH1120@openzaurus.ucw.cz>
References: <20040731210314.GA3436@linux.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040731210314.GA3436@linux.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The merged swsusp in 2.6.7-rc2-mm1 doesn't turn off the hard drive before
> before shutdown. This results in a rather abrupt sound during suspend on my
> IBM Thinkpad X31. I tried adding a call to device_shutdown(); in disk.c
> after line 52, this seems to fix the problem.

Can you submit patch, CC-ing patrick?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

