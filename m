Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVFASNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVFASNq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVFASM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:12:59 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:11146 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261510AbVFASIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:08:43 -0400
Date: Wed, 1 Jun 2005 11:08:36 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][1/3] RapidIO support: core
Message-ID: <20050601110836.A16559@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a RapidIO subsystem to the kernel. RIO is a switched
fabric interconnect used in higher-end embedded applications.
The curious can look at the specs over at http://www.rapidio.org

The core code implements enumeration/discovery, management of
devices/resources, and interfaces for RIO drivers.

There's a lot more to do to take advantages of all the hardware
features. However, this should provide a good base for folks
with RIO hardware to start contributing.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

Patch is 108KB and can be found here:
ftp://source.mvista.com/pub/rio/l26_rio_core.patch

-Matt
