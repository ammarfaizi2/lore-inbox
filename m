Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130804AbQLTCDo>; Tue, 19 Dec 2000 21:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130846AbQLTCDY>; Tue, 19 Dec 2000 21:03:24 -0500
Received: from ccs.covici.com ([209.249.181.196]:39428 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S130804AbQLTCDR>;
	Tue, 19 Dec 2000 21:03:17 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 test12 ipchains doesn't work as module
From: John Covici <covici@ccs.covici.com>
Date: 19 Dec 2000 20:32:48 -0500
Message-ID: <m3lmtblvwf.fsf@ccs.covici.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I configured 2.4.0 test12 to use the ipchains compatability option as
a module and I did a modprobe on all the other modules in that section
of such as iptable_filter, etc.  When I tried to do the modprobe on
ip_nf_compat_ipchains (if I have the name correct) it said device or
resource busy.  When I built it into the kernel, this problem went
away.

Do I need to do those modprobes as I have done in 2.2?

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
