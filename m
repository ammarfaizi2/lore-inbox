Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264861AbUEUX3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264861AbUEUX3D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264976AbUEUX1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:27:18 -0400
Received: from zeus.kernel.org ([204.152.189.113]:3760 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264861AbUEUXIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:08:46 -0400
Date: Fri, 21 May 2004 10:29:49 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org,
       "Surendra I." <surendrai@esntechnologies.co.in>
Subject: Re: protecting source code in 2.6
Message-ID: <20040521082949.GA10778@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	"Surendra I." <surendrai@esntechnologies.co.in>
References: <1118873EE1755348B4812EA29C55A97222FD0D@esnmail.esntechnologies.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118873EE1755348B4812EA29C55A97222FD0D@esnmail.esntechnologies.co.in>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2004, Jinu M. wrote:

> The device interface module is proprietary source and we don't intend
> to distribute it with source code on GPL license.

Why is there a reason to lock down the source of the actual driver?

Can we assume the hardware is so cheap that all the smartness is in the
software? Why would anyone buy the hardware then? What performance could
we expect?

What kind of device is yours that users would not have an alternative to
buy something with open-source driver that has the same function?

Plus, are you committing to:

- compile and re-compile (after kernel changes) your module over and
  over again, to keep it working?

- provide the module for any platform that accepts the hardware
  (ix86, AMD64, PowerPC, sparc, sparc64, ...)

- guarantee the users of your hardware a support period, say, three years
  at least, during which you will continue to provide updated binary
  modules, if need be, for particular distributions?

- support and pre-filter all bug reports, whether the problem originates
  in your closed source driver

- why are _you_ trying to profit from open source without contributing
  back?

- the next item I cannot conceive right now but someone will bring up?

I wonder why anyone would be motivated to help, for free, with a
closed-source driver.

The situation for you will likely change completely should you decide to
open-source the driver - vendors who have chosen that path have usually
received support, often their drivers have ultimately become part of the
kernel, so the users won't have to go search for the driver themselves,
hassling with nonstandard installation procedures and all that, and your
visibility in hardware data bases may help the sales of your hardware.

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95
