Return-Path: <linux-kernel-owner+w=401wt.eu-S1161058AbXALJ6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbXALJ6a (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 04:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbXALJ6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 04:58:30 -0500
Received: from 16.169.aberger.at ([193.186.169.16]:3149 "EHLO
	asmtp.proserver1.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1161058AbXALJ63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 04:58:29 -0500
X-Greylist: delayed 1897 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2007 04:58:28 EST
Message-ID: <46816.80.120.2.52.1168594005.squirrel@secure.proserver1.at>
Date: Fri, 12 Jan 2007 10:26:45 +0100 (CET)
Subject: Problem with out-dated Linux 2.14-rt system
From: "Harald Krammer" <Harald.Krammer@hkr.at>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have running Linux Version 2.6.14-rc5-rt7 on ARM EP9302 and
in the most of time all works fine for me, but very seldom
my system crash.

With a JTAG-debugger I dumped out the kernel-log message and saw
following entries:

<4>BUG: unbalanced irq-handler preempt count in timer_interrupt+0x0/0x50!
<4>entered with 00010002, exited with 00000000.

What could be the reason for that? A racing ? If it true, how I can find
it out? BTW, I enabled all debug-options without to get
more information's.

I know this version is totally out-dated, but it is my current playground
to get a deeper understanding and it's a try to fix a problem.

Any hints are welcome!
Thanks,
Harald

-- 
Harald Krammer
Brucknerstrasse 33
A - 4020  Linz
AUSTRIA

Mobil +43.(0) 664. 130 59 58
Mail: Harald.Krammer (at) hkr.at

