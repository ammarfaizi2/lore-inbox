Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVARPfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVARPfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVARPfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:35:18 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:4571 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261323AbVARPfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:35:07 -0500
Date: Tue, 18 Jan 2005 09:34:50 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH 0/4] ppc32: platform_device conversion from OCP
Message-ID: <Pine.LNX.4.61.0501180925070.11311@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I would like to try to get these patches into 2.6.11.  They add 
infrastructure for all ppc sub-archs to use platform_devices instead of 
OCP.  Additionally, I've converted the 85xx sub-arch and gianfar enet 
driver (used by 85xx) over to using platform_device and the new 
infrastructure.

The sooner these get in the easier it will be to convert the other 
sub-archs and drivers to platform_device and remove OCP.

- kumar
