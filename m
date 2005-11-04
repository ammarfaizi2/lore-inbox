Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVKDSpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVKDSpb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 13:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVKDSpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 13:45:30 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45328 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750823AbVKDSpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 13:45:30 -0500
Date: Fri, 4 Nov 2005 18:45:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: ambat sasi nair <sasin@iname.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmc_block.c - cmd24/25 do not expect r1b
Message-ID: <20051104184510.GB12026@flint.arm.linux.org.uk>
Mail-Followup-To: ambat sasi nair <sasin@iname.com>,
	linux-kernel@vger.kernel.org
References: <20051104063233.3FA7183C02@ws1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104063233.3FA7183C02@ws1-1.us4.outblaze.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 02:32:33PM +0800, ambat sasi nair wrote:
> just for the reference of any1 working on the mmc/sd driver for
> linux - write block commands (24/25) expect r1 and not r1b as
> coded in the mmc_block.c.

That corresponds to the documents I have, thanks for spotting it.
Fixed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
