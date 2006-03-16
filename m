Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752187AbWCPJL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbWCPJL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 04:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbWCPJL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 04:11:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40145 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750804AbWCPJL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 04:11:57 -0500
Date: Thu, 16 Mar 2006 01:09:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mark Brown <broonie@sirena.org.uk>
Cc: thockin@hockin.org, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] natsemi: Add support for using MII port with no PHY
Message-Id: <20060316010902.57e3a98b.akpm@osdl.org>
In-Reply-To: <20060312205303.869316000@mercator.sirena.org.uk>
References: <20060312192259.929734000@mercator.sirena.org.uk>
	<20060312205303.869316000@mercator.sirena.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@sirena.org.uk> wrote:
>
>  +	if (np->ignore_phy && (ecmd->autoneg == AUTONEG_ENABLE ||
>  +			       ecmd->port == PORT_INTERNAL)) {

What's PORT_INTERNAL?  ethtool doesn't appear to define that.

drivers/net/natsemi.c: In function `netdev_set_ecmd':
drivers/net/natsemi.c:2989: `PORT_INTERNAL' undeclared (first use in this function)
drivers/net/natsemi.c:2989: (Each undeclared identifier is reported only once
drivers/net/natsemi.c:2989: for each function it appears in.)

