Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbUDAN7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 08:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbUDAN7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 08:59:21 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19677
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262914AbUDAN7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 08:59:20 -0500
Date: Thu, 1 Apr 2004 15:59:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: disable-cap-mlock
Message-ID: <20040401135920.GF18585@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oracle needs this sysctl, I designed it and Ken Chen implemented it. I
guess google also won't dislike it.

This is a lot simpler than the mlock rlimit and this is people really
need (not the rlimit). The rlimit thing can still be applied on top of
this. This should be more efficient too (besides its simplicity).

can you apply to mainline?

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.5-rc3-aa1/disable-cap-mlock-1
