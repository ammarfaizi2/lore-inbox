Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUIZUDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUIZUDm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 16:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUIZUDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 16:03:42 -0400
Received: from sa9.bezeqint.net ([192.115.104.23]:51878 "EHLO sa9.bezeqint.net")
	by vger.kernel.org with ESMTP id S263540AbUIZUDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 16:03:41 -0400
Date: Sun, 26 Sep 2004 23:04:51 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG: 2.6.9-rc2-bk11] input completely dead in X
Message-ID: <20040926210450.GA2960@luna.mooo.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried kernel 2.6.9-rc2-bk11 and when I start X input is completely
dead (including num-lock, caps-lock, sysrq and mouse). The computer is
otherwise functional (I can log in with ssh, kill X and everything is
functional again).

In the console is completely functional, before and after starting X.

I had exactly the same behavior with mm kernels from version 2.6.7 or
2.6.8 (not sure) onwards, which was fixed by reversing the bk-input
patch.

kernel 2.6.9-rc2 works fine.

The machine is Sony Vaio PCG-FXA53 laptop (amd 1500+ and via chipset).
The keyboard is recognized as ps2 AFAIK and the touchpad is an alps
(with the alps kernel patch).
