Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTJLG3p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 02:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbTJLG3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 02:29:45 -0400
Received: from cartman.gtsi.sk ([62.168.96.9]:59573 "EHLO cartman.gtsi.sk")
	by vger.kernel.org with ESMTP id S263426AbTJLG3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 02:29:44 -0400
Subject: Oops on APM wakeup on 2.4.22/23-pre, works with 2.6.0-test
To: linux-kernel@vger.kernel.org
Date: Sun, 12 Oct 2003 08:29:41 +0200 (CEST)
Cc: sfr@canb.auug.org.au, apmd-list@lists.nit.ca
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1A8ZjZ-0000gQ-00@trillian.meduna.org>
From: Stanislav Meduna <stano@meduna.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to get the suspend to RAM working on an old
Compaq Armada 1592 notebook.

With the kernel 2.4.22 from Debian unstable or with vanilla
2.4.23-pre7 I am getting an Oops on wakeup in apmd.
Unfortunately I am not able to capture it, as there
is an endless series of Oopsen with stacks longer
than tens of screens - judging from the patterns in
the addresses this actually looks like some recursive
call somewhere. It is completely reproducible. Nothing
is logged on the disk - the machine never comes up
enough to be able to write something to disk.

With 2.6.0-test7 the wakeup works fine - unfortunately I can't
use 2.6.0 due to other problems such as unstable PCMCIA
when removing devices and inability to compile standalone
pcmcia-cs modules against it (I think both are known).

apmd is 3.2.0 from Debian unstable.

Getting the oops through a serial console is a bit complicated
right now (have to solder null-modem cable first etc), so I would
like to know first whether this kind of problem is known
and whether there are some other suggested things/patches
to try.

Please, Cc: the followups to me, I don't read the lists
regularly.

Thanks
-- 
                                  Stano

