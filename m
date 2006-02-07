Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbWBGWOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWBGWOw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWBGWOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:14:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12819 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965037AbWBGWOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:14:51 -0500
Date: Tue, 7 Feb 2006 23:14:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ebs@ebshome.net
Cc: linuxppc-embedded@ozlabs.org, netdev@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: IBM_EMAC_PHY_RX_CLK_FIX depends on non-existing option 440GR
Message-ID: <20060207221449.GB3524@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Luc Leger <reiga@dspnet.fr.eu.org> reported the following:

from drivers/net/Kconfig:
config IBM_EMAC_PHY_RX_CLK_FIX
        bool "PHY Rx clock workaround"
        depends on IBM_EMAC && (405EP || 440GX || 440EP || 440GR)
-> maybe this is 440GP ?


The non-existing CONFIG_440GR is also present in the driver itself.

Is this a typo or a not yet merged platform?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

