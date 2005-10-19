Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVJSBeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVJSBeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbVJSBdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:33:41 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:33811 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932437AbVJSBdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:33:22 -0400
Date: Tue, 18 Oct 2005 21:31:01 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com
Subject: [patch 2.6.14-rc3 0/3] misc fixes/cleanups for sundance
Message-ID: <10182005213101.12694@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a little cleanup from me, and some fixes snarfed from the
ICPlus (chip vendor) version of the driver.

	-- Get rid of if (1) { ... } block in sundance_probe1

	-- Change PHY probing to start from MII address 0

	-- Expand the mask used when resetting the chip

Patches to follow...
