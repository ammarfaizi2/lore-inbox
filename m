Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262416AbSKMSla>; Wed, 13 Nov 2002 13:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbSKMSla>; Wed, 13 Nov 2002 13:41:30 -0500
Received: from mail-3.tiscali.it ([195.130.225.149]:23265 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S262416AbSKMSl2>;
	Wed, 13 Nov 2002 13:41:28 -0500
Date: Wed, 13 Nov 2002 19:48:05 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: lord@sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.5.47] Unable to load XFS module
Message-ID: <20021113184805.GA777@dreamland.darkstar.net>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I'm playing with kernel 2.5.47. XFS support is compiled as module and at
boot time, while mounting /home, I get this:

insmod /lib/modules/2.5.47/kernel/fs/xfs/xfs.o failed

Then, trying to modprobe xfs by hand:

/lib/modules/2.5.47/kernel/fs/xfs/xfs.o: unresolved symbol page_states__per_cpu
/lib/modules/2.5.47/kernel/fs/xfs/xfs.o: insmod /lib/modules/2.5.47/kernel/fs/xfs/xfs.o failed
/lib/modules/2.5.47/kernel/fs/xfs/xfs.o: insmod xfs failed

I'm using modutils 2.4.19

ciao,
Luca
-- 
Home: http://kronoz.cjb.net
Windows /win'dohz/ n. : thirty-two  bit extension and graphical shell to
a sixteen  bit patch to an  eight bit operating system  originally coded
for a  four bit microprocessor  which was  written by a  two-bit company
that can't stand a bit of competition.
