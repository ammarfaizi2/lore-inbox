Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbTH3IXd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 04:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTH3IXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 04:23:33 -0400
Received: from bellini.kjist.ac.kr ([203.237.42.6]:11012 "EHLO
	bellini.kjist.ac.kr") by vger.kernel.org with ESMTP id S261698AbTH3IXc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 04:23:32 -0400
From: ghugh Song <ghugh@kjist.ac.kr>
To: linux-kernel@vger.kernel.org
Subject: bug in the alas patch? (Re: Linux 2.4.22-ac1)
Message-Id: <20030830082328.AEB1879552@bellini.kjist.ac.kr>
Date: Sat, 30 Aug 2003 17:23:28 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen (andersen@codepoet.org) wrote
> I made a patch adding alsa to 2.4.x a while back... You just
> need to apply these three patches.
> 
> http://codepoet.org/kernel/080-proc_dir_entry.bz2
> http://codepoet.org/kernel/081-export-rtc.bz2
> http://codepoet.org/kernel/082_alsa-0.9.2.bz2
> 
> I've not updated it since 2.4.22-rc2, but it should patch into
> 2.4.22 without any problem... It works for me anyways.
> 
> -Erik

There must a newly-created bug since then.
I am getting

# modprobe soundcore
/lib/modules/2.4.22-ac1/kernel/sound/soundcore.o: unresolved symbol snd_compat_devfs_remove
/lib/modules/2.4.22-ac1/kernel/sound/soundcore.o: insmod /lib/modules/2.4.22-ac1/kernel/sound/soundcore.o failed
/lib/modules/2.4.22-ac1/kernel/sound/soundcore.o: insmod soundcore failed


Thanks.

Hugh
