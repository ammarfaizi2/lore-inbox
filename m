Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbTJYRaX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 13:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTJYRaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 13:30:23 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:38415 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S262729AbTJYRaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 13:30:21 -0400
From: "David S. Geirsson" <david@loesje.nl>
Date: Sat, 25 Oct 2003 19:30:17 +0200
To: linux-kernel@vger.kernel.org
Subject: setmax for clipping disks
Message-ID: <20031025173017.GA621@hyper>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry that this is a bit off-topic, but the linux-kernel list seems
to be the only list google finds that has had any really useful
information about this subject (not surprisingly :).

I have an old laptop (mitac 6120N, for those that are interested). This
laptop seems to not support drives larger than 20GB (some arbitrary BIOS
limit?). It simply hangs while detecting IDE devices. I really would
like to buy a new 80GB IBM drive. I have seen references to a program
called setmax, that can soft-clip drives to look to the BIOS like
smaller drives. I have also seen references to Andre Hedrick's IDE
patches. I was wondering - if I use Andre Hedrick's patch, will that
mean that it will detect the real capacity of a drive even if it has
been setmax-clipped before? Or will I need to run setmax after bootup?

Also, do bootloaders (GRUB or LILO, mostly) have problems when the 
partition table references partitions outside the disk's capacity?

Also (since I'm asking anyway) has anyone tried the setmax utility on
IBM/Hitachi vendored laptop drives?

Thanks, and sorry for the off-topic questions.

PS: If anyone knows of an answer to any of these, could you please CC me
on replies? I am not subscribed to the list (my mailbox would never
forgive me :).

-- 
David S. Geirsson
david@loesje.nl
+31 642561928 (0642561928)
