Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271390AbTHRLTe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 07:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271394AbTHRLTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 07:19:34 -0400
Received: from [62.75.136.201] ([62.75.136.201]:27620 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S271390AbTHRLTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 07:19:33 -0400
Message-ID: <3F40B665.2010407@g-house.de>
Date: Mon, 18 Aug 2003 13:20:05 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030815
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: parport_pc Oops with 2.6.0-test3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

as the subject might presume, the parport_pc modules oopses when it's 
unloaded. so on every shutdown i see an Oops on the console, which get 
logged to syslog then:

http://christian.go4more.de/parport/parport_pc-init6.txt

yes, the kernel is tainted with the nvidia module, i try to reprodduce 
later on without nvidia.

upon manual "rmmod parport_pc", this exits with a seg-fault, the log shows:

http://christian.go4more.de/parport/parport_pc-rmmod.txt

This is with vanilla 2.6.0-test3, i386, Debian unstable (glibc
2.3.2-2, kernel compiled with gcc (GCC) 3.3.2 20030812 (Debian prerelease).

more info available, of course.

Thanks,
Christian.

PS: i have 2.6.0-test3 (and previous versions) running now for 
days/weeks und X11, normal use, sometimes under load, some quirks, but 
*no* crashes! Thank you!

-- 
BOFH excuse #333:

A plumber is needed, the network drain is clogged

