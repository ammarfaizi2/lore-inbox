Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267134AbRG1VVQ>; Sat, 28 Jul 2001 17:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267180AbRG1VVH>; Sat, 28 Jul 2001 17:21:07 -0400
Received: from ohiper1-178.apex.net ([209.250.47.193]:12548 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S267134AbRG1VVA>; Sat, 28 Jul 2001 17:21:00 -0400
Date: Sat, 28 Jul 2001 16:21:17 -0500
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Port tdfxfb to new-style PCI API
Message-ID: <20010728162117.A9266@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 4:15pm  up 23 min,  1 user,  load average: 1.00, 1.00, 0.80
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I have created a patch that changes the 3dfx framebuffer driver so that
it uses the new-style PCI api.  Additionally, it adds the ability to
pass parameters to the module (previously these were only availible when
built into the kernel) and makes the indention conformant to
Coding-Style.

I've tested it myself as both module and built-in with no problems, but
you can never test too much.  I'd like to ask adventuresome users of
this driver to try out my patch, with the hopeful end result of
inclusion into the kernel.

The patch is availible from:
http://www.apex.net/users/trwalter/tdfxfb-patch.gz
Its 22k compressed (large because of style/indention changes), so I was
hesitant to post it to the list.

Many thanks in advance to testers, comments are welcome.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
