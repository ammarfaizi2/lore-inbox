Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbVJSBcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbVJSBcX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbVJSBcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:32:23 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:25107 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751515AbVJSBcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:32:22 -0400
Date: Tue, 18 Oct 2005 21:30:59 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, shemminger@osdl.org, mlindner@syskonnect.de,
       rroesler@syskonnect.de
Subject: [patch 2.6.14-rc4 0/3] sk98lin: neuter and prepare for removal
Message-ID: <10182005213059.12304@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches take steps towards removing sk98lin from the upstream
kernel.

	-- Remove sk98lin's MODULE_DEVICE_TABLE to avoid
	confusing userland tools about which driver to load;

	-- Mark sk98lin as Obsolete in the MAINTAINERS file; and,

	-- Add sk98lin to the feature-removal-schedule.txt file in the
	Documentation directory.

I accept the possibility that I may be jumping the gun on this.
However, I think it is worth opening this discussion.

Patches to follow...
