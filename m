Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270447AbTGMXb2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 19:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270448AbTGMXb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 19:31:27 -0400
Received: from aneto.able.es ([212.97.163.22]:6548 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S270447AbTGMXb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 19:31:26 -0400
Date: Mon, 14 Jul 2003 01:40:24 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Andrea Arcangeli <andrea@suse.de>
Subject: gcc-3.3.1-hammer vs current pre
Message-ID: <20030713234024.GA2346@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

One good and one bad news...

The good:
Current 22-pre5 builds at -O1 level. I always thought it was mandatory to
build at -O2...At least it can be useful to detect optimizer bugs...

And the bad. The current gcc in mandrakke cooker miscompiles the kernel.
Current 2.4.22-pre5 (plain, even a comma touched) works if built with -O1
and breaks with -O2 (does not pass init launch). As it is based on
the hammer branch from SuSE, I think this also affects SuSE developers,
if not corrected in their tree yet.

Is there any way to set compile flags for _subsystems_ ? To start
a search on what breaks at -O2.

[OT] (off-topic, not Operacion Triunfo -bleh- ...)
BTW, is anybody from Mandrake reading this ? The cooker list looks dead
since a week or so. If someone reads this, plz mail me in private.

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre2-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))
