Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbTLFJud (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 04:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264974AbTLFJuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 04:50:32 -0500
Received: from main.gmane.org ([80.91.224.249]:8650 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264971AbTLFJuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 04:50:25 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <jens-usenet@spamfreemail.de>
Subject: Help: 2.4 -> 2.6 (test11,bk2) kernel module file size (due to debug options?)
Date: Sat, 06 Dec 2003 10:17:50 +0100
Message-ID: <bqs6rq$vv3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart9916970.C3pLvd3usl"
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9916970.C3pLvd3usl
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit

Hi,

after installing (actually - creating a debian package for) 2.6.0-test11-bk2
I have this:

2.3M    /boot
366M    /lib/modules/2.6.0-test11-bk2                           !!!
15k     /usr/share/doc/kernel-image-2.6.0-test11-bk2

Almost all .ko files are >200k in size. What kernel setting is/can be
responsible for this?

N.B. I'm compiling the test11 to test it on my hardware, so ATM I'm not too
worried about size if debugging is made easier. But this is _quite_ a
drastic size increase compared to 2.4.22, where most driver files were
10-40k in size.

.config attached. Compiled cleanly, with a couple warnings. 
I'll now test it on my laptop.


Thanks!


-- 
Jens Benecke
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--nextPart9916970.C3pLvd3usl--
