Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbUA3WHC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 17:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUA3WHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 17:07:02 -0500
Received: from stewie.egr.unlv.edu ([131.216.22.9]:4525 "EHLO
	mail.egr.unlv.edu") by vger.kernel.org with ESMTP id S263639AbUA3WG7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 17:06:59 -0500
Subject: fh_verify: no root_squashed access hundreds of times a second
From: Andrew Gray <grayaw@egr.unlv.edu>
To: linux-kernel@vger.kernel.org
Organization: University of Nevada Las Vegas - College of Engineering
Message-Id: <1075500418.12519.128.camel@blargh>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 30 Jan 2004 14:06:58 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not subscribed to the linux-kernel list, I would appreciate a CC on
any replies, but I will be watching the list as well.

I am using kernel 2.4.24 on a heavily-used NFS server.  I am receiving
hundreds of messages like:

"kernel: fh_verify: no root_squashed access at sessions/lastsession."

in my messages log, usually accompanied by a "last message repeated 6497
times" a minute or so later.  I'm gathering it is just reporting it is
denying root access to a share, which is fine and exactly what I asked
for.  Is there anyway to shut this logging off without just wiping the
line from fs/nfsd/nfsfh.c?  I really can't afford to be rebooting the
box to install a new kernel right now.  I've searched google,
linux-kernel, and other resources, and while I've found others with the
same problem, no solutions have been posted.

-- 
Andrew Gray
Systems Administrator
College of Engineering
University of Nevada, Las Vegas


