Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbTFVQxZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 12:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbTFVQxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 12:53:25 -0400
Received: from smtp-2.concepts.nl ([213.197.30.52]:61713 "EHLO
	smtp-2.concepts.nl") by vger.kernel.org with ESMTP id S264638AbTFVQxS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 12:53:18 -0400
Subject: 2.4.21 doesn't boot: /bin/insmod.old: file not found
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1056301678.2183.10.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 22 Jun 2003 19:07:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I'm trying to get 2.4.21 to run (2.4.20 runs nicely), and I get the
above error ("/bin/insmod.old: file not found"), after which it stops
booting.

After that, I installed the newest modutils (2.4.25) and
module-init-tools (tried both 0.9.12 and 0.9.13-pre), created symlinks
in /bin for all *mod* tools pointing to /sbin/$file, and I still cannot
get 2.4.21 to get further than this error (obviously, /bin/insmod.old
_is there_, I'm not that stupid. ;) ). I use initrd with filesystem
modules and some more in it, so obviously it fails with a panic saying
that /sbin/init wasn't found (no single HD mounted).

Of course, I could place ext3 in-kernel, but that's not the point.
2.4.21 doesn't boot for me as is - 2.4.20 does. I can't continue 2.5.x
testing if I remove the module-init-tools and only use modutils (I'm
doing that on another system, and that one works well with 2.4.21).

Does this sound familiar to anyone? Does someone know a solution that
will allow me to keep on using initrd images in 2.4.x, while also being
able to test 2.5.x?

System: RH73 (mostly), gcc-2.96.

Thanks,

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

