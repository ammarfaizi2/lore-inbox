Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVKKPcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVKKPcV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 10:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVKKPcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 10:32:21 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:51628 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750806AbVKKPcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 10:32:20 -0500
Date: Fri, 11 Nov 2005 08:32:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: SysFS 'module' params with CONFIG_MODULES=n
Message-ID: <20051111153220.GQ3839@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.6.14, and probably newer, a system where CONFIG_MODULES=n
/sys/module/foo/parameters/param fails:

# cat /sys/module/tcp_bic/parameters/low_window
cat: /sys/module/tcp_bic/parameters/low_window: Permission denied

But just changing MODULES to y:

# cat /sys/module/tcp_bic/parameters/low_window
14

Is this intentional or fixable?  Just an observation right now, thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
