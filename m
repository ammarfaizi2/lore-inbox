Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933268AbWKNAhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933268AbWKNAhx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 19:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933269AbWKNAhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 19:37:53 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:53258
	"HELO linuxace.com") by vger.kernel.org with SMTP id S933268AbWKNAhw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 19:37:52 -0500
Date: Mon, 13 Nov 2006 16:37:52 -0800
From: Phil Oester <kernel@linuxace.com>
To: linux-kernel@vger.kernel.org
Subject: make menuconfig regression in 2.6.19-rc
Message-ID: <20061114003752.GA15295@linuxace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 350b5b76384e77bcc58217f00455fdbec5cac594, the default menuconfig
color scheme was changed to bluetitle.  This breaks the highlighting
of the selected item for me with TERM=vt100.  The only way I can see
which item is selected is via:

    make MENUCONFIG_COLOR=mono menuconfig

Which restores the pre-2.6.19 white on black highlighting.  

Sam?

Phil
