Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422869AbWJOIEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422869AbWJOIEZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 04:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422872AbWJOIEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 04:04:25 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:24974 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S1422869AbWJOIEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 04:04:23 -0400
Date: Sun, 15 Oct 2006 10:04:21 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org
Subject: undefined reference to highest_possible_node_id
Message-ID: <20061015080421.GA17399@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A 2.6.19-rc2 pseries_defconfig build with SMP=n will not link,
highest_possible_node_id is undefined because NODES_SHIFT == 4.
How can this be fixed properly?

