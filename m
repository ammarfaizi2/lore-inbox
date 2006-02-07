Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWBGW5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWBGW5Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWBGW5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:57:15 -0500
Received: from gate.ebshome.net ([64.81.67.12]:26272 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S1030226AbWBGW5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:57:14 -0500
Date: Tue, 7 Feb 2006 14:57:13 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: linuxppc-embedded@ozlabs.org, netdev@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: Re: IBM_EMAC_PHY_RX_CLK_FIX depends on non-existing option 440GR
Message-ID: <20060207225713.GA6933@gate.ebshome.net>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linuxppc-embedded@ozlabs.org, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Jean-Luc Leger <reiga@dspnet.fr.eu.org>
References: <20060207221449.GB3524@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207221449.GB3524@stusta.de>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 11:14:49PM +0100, Adrian Bunk wrote:
> Jean-Luc Leger <reiga@dspnet.fr.eu.org> reported the following:
> 
> from drivers/net/Kconfig:
> config IBM_EMAC_PHY_RX_CLK_FIX
>         bool "PHY Rx clock workaround"
>         depends on IBM_EMAC && (405EP || 440GX || 440EP || 440GR)
> -> maybe this is 440GP ?
> 
> 
> The non-existing CONFIG_440GR is also present in the driver itself.
> 
> Is this a typo or a not yet merged platform?

Not yet merged platform.

-- 
Eugene

