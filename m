Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWALNxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWALNxK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 08:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWALNxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 08:53:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42000 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932220AbWALNxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 08:53:09 -0500
Date: Thu, 12 Jan 2006 13:53:02 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, oliver@neukum.org
Subject: Re: need for packed attribute
Message-ID: <20060112135302.GC5700@flint.arm.linux.org.uk>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	oliver@neukum.org
References: <200601121227.k0CCRCB8016162@alkaid.it.uu.se> <20060112134729.GB5700@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112134729.GB5700@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 01:47:29PM +0000, Russell King wrote:
> Due to lack of manpower on the Linux side (iow, more or less just me)
> this became the ABI of the early ARM Linux a.out toolchain.  At that
> time, I did not consider this to be a problem - it wasn't a problem
> as far as the kernel was concerned.

Before someone takes that the wrong way - Richard Earnshaw worked on
porting binutils + gcc to the ARM architecture.  I worked on converting
that toolchain to work for ARM Linux - supporting the a.out shared
libraries and other Linux specific features.

Changing the ABI was, and still is completely outside my level of
knowledge of gcc.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
