Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268686AbUHNMIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268686AbUHNMIN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 08:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268687AbUHNMIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 08:08:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:51843 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268686AbUHNMIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 08:08:12 -0400
Date: Sat, 14 Aug 2004 14:08:10 +0200
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.8 freezing over night
Message-Id: <20040814140810.5109b58e.ak@suse.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI -

I'm seeing the same issue I saw with earlier 2.6.8rcs on a quad Opteron. When left running
over night with moderate background load (some build jobs) it freezes. No sysrq or ping or 
anything, also no oops one the console. The machine ran previously only 2.6.5 based
kernels which worked fine.

-Andi
