Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267123AbTBHWiZ>; Sat, 8 Feb 2003 17:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267125AbTBHWiY>; Sat, 8 Feb 2003 17:38:24 -0500
Received: from [212.156.4.132] ([212.156.4.132]:38117 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S267123AbTBHWiY>;
	Sat, 8 Feb 2003 17:38:24 -0500
Date: Sun, 9 Feb 2003 00:48:08 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] REPORTING-BUGS
Message-ID: <20030208224808.GA7354@ttnet.net.tr>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-PGP-Fingerprint: 15 C0 AA 31 59 F9 DE 4F 7D A6 C7 D8 A0 D5 67 73
X-PGP-Key-ID: 0x5C447959
X-PGP-Key-Size: 2048 bits
X-Editor: GNU Emacs 21.2.1
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds some extra info for bug-reporting.


--- REPORTING-BUGS.orig Sun Feb  9 00:18:06 2003
+++ REPORTING-BUGS      Sun Feb  9 00:32:00 2003
@@ -9,7 +9,7 @@
 bug report. This explains what you should do with the "Oops" information
 to make it useful to the recipient.

-      Send the output the maintainer of the kernel area that seems to
+      Send the output to the maintainer of the kernel area that seems to
 be involved with the problem. Don't worry too much about getting the
 wrong person. If you are unsure send it to the person responsible for the
 code relevant to what you were doing. If it occurs repeatably try and
@@ -19,6 +19,11 @@
       If you are totally stumped as to whom to send the report, send it to
 linux-kernel@vger.kernel.org. (For more information on the linux-kernel
 mailing list see http://www.tux.org/lkml/).
+
+      Before sending the report, also make sure that you are getting the
+same oops with the later stable/development versions of your kernel (if any).
+There is a chance that it may have already been fixed in the later kernels.
+This may not be easy to see if the bug is not reproducible, though.

 This is a suggested format for a bug report sent to the Linux kernel mailing
