Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbULLEtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbULLEtc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 23:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbULLEtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 23:49:32 -0500
Received: from mgr2.xmission.com ([198.60.22.202]:33152 "EHLO
	mgr2.xmission.com") by vger.kernel.org with ESMTP id S261633AbULLEtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 23:49:25 -0500
Message-ID: <41BBCDD9.5080603@xmission.com>
Date: Sat, 11 Dec 2004 21:49:29 -0700
From: maxer1 <maxer1@xmission.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sk98lin patch 7.09 hiccups on 2.6.10-rc3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 166.70.55.125
X-SA-Exim-Mail-From: maxer1@xmission.com
X-SA-Exim-Version: 4.0 (built Sat, 24 Apr 2004 12:31:30 +0200)
X-SA-Exim-Scanned: Yes (on mgr1.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the output when attempting to patch kernel 2.6.10-rc3 with the 
driver patch from syskonnect.com:

cat /home/raxet/DriverInstall/sk98lin_v7.09_2.6.9_patch | patch -p1
patching file drivers/net/sk98lin/h/lm80.h
patching file drivers/net/sk98lin/h/skaddr.h
patching file drivers/net/sk98lin/h/skcsum.h
patching file drivers/net/sk98lin/h/skdebug.h
patching file drivers/net/sk98lin/h/skdrv1st.h
patching file drivers/net/sk98lin/h/skdrv2nd.h
Hunk #5 FAILED at 212.
1 out of 6 hunks FAILED -- saving rejects to file 
drivers/net/sk98lin/h/skdrv2nd.h.rej
patching file drivers/net/sk98lin/h/skerror.h
patching file drivers/net/sk98lin/h/skgedrv.h
patching file drivers/net/sk98lin/h/skgehw.h
patching file drivers/net/sk98lin/h/skgehwt.h
patching file drivers/net/sk98lin/h/skgei2c.h
patching file drivers/net/sk98lin/h/skgeinit.h
patching file drivers/net/sk98lin/h/skgepnm2.h
patching file drivers/net/sk98lin/h/skgepnmi.h
patching file drivers/net/sk98lin/h/skgesirq.h
patching file drivers/net/sk98lin/h/skgetwsi.h
patching file drivers/net/sk98lin/h/ski2c.h
patching file drivers/net/sk98lin/h/skqueue.h
patching file drivers/net/sk98lin/h/skrlmt.h
patching file drivers/net/sk98lin/h/sktimer.h
patching file drivers/net/sk98lin/h/sktwsi.h
patching file drivers/net/sk98lin/h/sktypes.h
patching file drivers/net/sk98lin/h/skversion.h
patching file drivers/net/sk98lin/h/skvpd.h
patching file drivers/net/sk98lin/h/sky2le.h
patching file drivers/net/sk98lin/h/xmac_ii.h
patching file drivers/net/sk98lin/Makefile
patching file drivers/net/sk98lin/skaddr.c
patching file drivers/net/sk98lin/skcsum.c
patching file drivers/net/sk98lin/skdim.c
patching file drivers/net/sk98lin/skethtool.c
patching file drivers/net/sk98lin/skge.c
Hunk #2 FAILED at 36.
1 out of 98 hunks FAILED -- saving rejects to file 
drivers/net/sk98lin/skge.c.rej
patching file drivers/net/sk98lin/skgehwt.c
patching file drivers/net/sk98lin/skgeinit.c
patching file drivers/net/sk98lin/skgemib.c
patching file drivers/net/sk98lin/skgepnmi.c
patching file drivers/net/sk98lin/skgesirq.c
patching file drivers/net/sk98lin/ski2c.c
patching file drivers/net/sk98lin/sklm80.c
patching file drivers/net/sk98lin/skproc.c
patching file drivers/net/sk98lin/skqueue.c
patching file drivers/net/sk98lin/skrlmt.c
patching file drivers/net/sk98lin/sktimer.c
patching file drivers/net/sk98lin/sktwsi.c
patching file drivers/net/sk98lin/skvpd.c
patching file drivers/net/sk98lin/skxmac2.c
patching file drivers/net/sk98lin/sky2.c
patching file drivers/net/sk98lin/sky2le.c
patching file Documentation/networking/sk98lin.txt
patching file drivers/net/Kconfig
Hunk #1 succeeded at 1979 (offset -82 lines).
Hunk #3 succeeded at 2003 (offset -82 lines).
Hunk #4 succeeded at 2181 with fuzz 2.
      
