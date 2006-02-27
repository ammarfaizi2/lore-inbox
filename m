Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWB0UfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWB0UfO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbWB0UfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:35:14 -0500
Received: from solarneutrino.net ([66.199.224.43]:58634 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1750717AbWB0UfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:35:12 -0500
Date: Mon, 27 Feb 2006 15:35:03 -0500
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, Erik Mouw <erik@harddisk-recovery.com>,
       Nick Warne <nick@linicks.net>
Subject: Re: Random reboots
Message-ID: <20060227203501.GA10719@tau.solarneutrino.net>
References: <20060215160036.GB17864@tau.solarneutrino.net> <ARSSpsNs.1140020437.1823510.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ARSSpsNs.1140020437.1823510.khali@localhost>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 05:20:37PM +0100, Jean Delvare wrote:
> There's one chip missing. If memory serves, this board has two hardware
> monitoring chips: one Winbond Super-I/O and one LM85-compatible SMBus
> chip. You are missing the i2c-amd756 driver in your kernel build
> (CONFIG_I2C_AMD756) which prevents you from accessing that second chip.

The second chip now reports the 12V line is nominal, and its temps are
all at or below 40C.  Reboots still occur with 2.6.15.4.

-ryan
