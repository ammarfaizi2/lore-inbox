Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030716AbWI0Tmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030716AbWI0Tmx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030717AbWI0Tmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:42:53 -0400
Received: from natreg.rzone.de ([81.169.145.183]:10742 "EHLO natreg.rzone.de")
	by vger.kernel.org with ESMTP id S1030716AbWI0Tmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:42:52 -0400
Date: Wed, 27 Sep 2006 21:42:36 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Zhang Yanmin <yanmin.zhang@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org
Subject: pcie_portdrv_restore_config undefined without CONFIG_PM
Message-ID: <20060927194235.GA9894@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PCI-Express AER implemetation: pcie_portdrv error handler

This patch breaks if CONFIG_PM is not enabled,
pcie_portdrv_restore_config() will be undefined.

