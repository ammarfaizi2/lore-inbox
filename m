Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269593AbRIMNfQ>; Thu, 13 Sep 2001 09:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271679AbRIMNfG>; Thu, 13 Sep 2001 09:35:06 -0400
Received: from ns.suse.de ([213.95.15.193]:46084 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S269593AbRIMNey>;
	Thu, 13 Sep 2001 09:34:54 -0400
Date: Thu, 13 Sep 2001 15:35:16 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Athlon crashing bug research.
Message-ID: <Pine.LNX.4.30.0109131525060.21239-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I believe I may be onto something, but I need some test
data from people who both are seeing crashes when the
athlon memcopy is used, and without.
Boot with a kernel that doesn't cause crashes
(Ie, no athlon optimisations)

The info I need can be displayed using my x86info
tool, available from  ..
ftp://ftp.suse.com/pub/people/davej/x86info/x86info-1.5.tgz

x86info -m is the important info here. You'll need the
cpuid/msr drivers installed, /dev/cpu nodes set up, and
you'll need to run it as root.

Mail the reports directly to me, rather than flooding
the mailing list with these reports.

x86info -m | mail davej@suse.de -s "Athlon bugdata"
would be just fine.

Any findings will be summarised and reported back
to the list.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

