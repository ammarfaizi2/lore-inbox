Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWCLVhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWCLVhr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 16:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWCLVhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 16:37:47 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:15273 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S932241AbWCLVhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 16:37:46 -0500
Date: Sun, 12 Mar 2006 13:41:13 -0800
From: thockin@hockin.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] natsemi: Add support for using MII port with no PHY
Message-ID: <20060312214113.GA15071@hockin.org>
References: <20060312192259.929734000@mercator.sirena.org.uk> <20060312205303.869316000@mercator.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060312205303.869316000@mercator.sirena.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 07:23:00PM +0000, Mark Brown wrote:
> This patch provides a module option which configures the natsemi driver
> to use the external MII port on the chip but ignore any PHYs that may be
> attached to it.  The link state will be left as it was when the driver
> started and can be configured via ethtool.  Any PHYs that are present
> can be accessed via the MII ioctl()s.
> 
> This is useful for systems where the device is connected without a PHY
> or where either information or actions outside the scope of the driver
> are required in order to use the PHYs.

Not that my opinion should hold much weight, having been absent from the
driver for some time, but yuck.  Is there no better way to do this thatn
sprinkling poo all over it?
