Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWHGNsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWHGNsg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 09:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWHGNsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 09:48:35 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:12552 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932094AbWHGNsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 09:48:35 -0400
Date: Mon, 7 Aug 2006 14:48:29 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Another stray 'io' reference
Message-ID: <20060807134829.GA2755@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus@drzeus.cx>,
	Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
References: <20060806234001.11770.63270.stgit@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806234001.11770.63270.stgit@poseidon.drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 01:40:04AM +0200, Pierre Ossman wrote:
> Another misuse of the global 'io' variable instead of the local 'base'.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
