Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVDWF1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVDWF1G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 01:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVDWF1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 01:27:06 -0400
Received: from dsl-202-52-56-051.nsw.veridas.net ([202.52.56.51]:26752 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261189AbVDWF1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 01:27:03 -0400
Subject: Compile error on microtek.c in drivers/usb/image/
From: James Purser <purserj@ksit.dynalias.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114234140.3074.6.camel@kryten>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 23 Apr 2005 15:29:00 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling from the git archive ran across this error, I changed the
offending FAILUR to FAILED and it compiled fine, however not knowing the
ins and outs, Im not sure if this is going to fix the problem.

System: Fedora Core 2
Compiler: gcc-3.3.3 (Redhat Version)

drivers/usb/image/microtek.c: In function `mts_scsi_abort':
drivers/usb/image/microtek.c:338: error: `FAILURE' undeclared (first use
in this function)
drivers/usb/image/microtek.c:338: error: (Each undeclared identifier is
reported only once
drivers/usb/image/microtek.c:338: error: for each function it appears
in.)
make[3]: *** [drivers/usb/image/microtek.o] Error 1
make[2]: *** [drivers/usb/image] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2


-- 
James Purser
http://ksit.dynalias.com

