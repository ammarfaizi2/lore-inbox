Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbVKHXSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVKHXSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbVKHXSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:18:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65033 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964850AbVKHXSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:18:15 -0500
Date: Tue, 8 Nov 2005 23:18:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Use __devexit_p in wbsd
Message-ID: <20051108231809.GG13357@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus@drzeus.cx>,
	Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
References: <20051107070458.6640.83631.stgit@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107070458.6640.83631.stgit@poseidon.drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 08:04:59AM +0100, Pierre Ossman wrote:
> wbsd_*_remove() is declared as __devexit but __devexit_p isn't used
> when taking their addresses.

This patch has been generated assuming that your PNP suspend/resume
patches are in... what do you want me to do with this?  Wait for
the PNP patches to hit mainline, or...?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
