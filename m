Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267123AbUBMRSg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 12:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267128AbUBMRSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 12:18:36 -0500
Received: from stewie.egr.unlv.edu ([131.216.22.9]:25482 "EHLO
	mail.egr.unlv.edu") by vger.kernel.org with ESMTP id S267123AbUBMRSd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 12:18:33 -0500
Subject: fh_verify: no root_squashed access hundreds of times a second again
From: Andrew Gray <grayaw@egr.unlv.edu>
To: linux-kernel@vger.kernel.org
Organization: University of Nevada Las Vegas - College of Engineering
Message-Id: <1076692518.15751.5.camel@blargh>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 13 Feb 2004 09:18:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not subscribed to the linux-kernel list, I would appreciate a CC on
any replies, but I will be watching the list as well.  I'm reposting
this message in the hope someone will answer - neither I nor the mailing
list got any replies last time.

I am using kernel 2.4.24 on a heavily-used NFS server. I am receiving
hundreds of messages like:

"kernel: fh_verify: no root_squashed access at sessions/lastsession."

in my messages log, usually accompanied by a "last message repeated 6497
times" a minute or so later. I'm gathering it is just reporting it is
denying root access to a share, which is fine and exactly what I asked
for. Is there anyway to shut this logging off without just wiping the
line from fs/nfsd/nfsfh.c? I really can't afford to be rebooting the box
to install a new kernel right now. I've searched google, linux-kernel,
and other resources, and while I've found others with the same problem,
no solutions have been posted.

-- 
Andrew Gray
Systems Administrator
College of Engineering
University of Nevada, Las Vegas


