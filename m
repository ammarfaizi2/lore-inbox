Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266435AbUFQKVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266435AbUFQKVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 06:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266446AbUFQKVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 06:21:24 -0400
Received: from vsmtp1b.tin.it ([212.216.176.141]:5295 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S266435AbUFQKVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 06:21:20 -0400
Message-ID: <40D1709C.8040902@stanchina.net>
Date: Thu, 17 Jun 2004 12:21:16 +0200
From: Flavio Stanchina <flavio@stanchina.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_porta-19605-1087467678-0001-2"
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Broken CREDITS file.
References: <1087437489.798.4.camel@ansel.lan> <20040616190927.003d3859.rddunlap@osdl.org>
In-Reply-To: <20040616190927.003d3859.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_porta-19605-1087467678-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Randy.Dunlap wrote:

> | N: Leonard N. Zubkoff
> I doubt it, since he died in a helicopter crash in Alaska a couple
> of years ago.  However, it seems to be OK with most of us that
> his name stays in the CREDITS file, so don't edit it so quickly.

Do we need an "hit by a bus" flag in the credits file? I think it would 
be a good way to remember people like Leonard *and* make sure that to 
one writes inadequate emails like the parent.

In this particular case,
H: Leonard Zubkoff was killed in a helicopter crash in Alaska on August 
29, 2002

...and maybe an additional
W: http://www.electricpenguin.com/filking/articles/zubkoff.html

Patch is attached.

-- 
Ciao, Flavio

--=_porta-19605-1087467678-0001-2
Content-Type: text/plain; name="lnz-RIP.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lnz-RIP.patch"

===== CREDITS 1.119 vs edited =====
--- 1.119/CREDITS	2004-05-29 09:28:48 +02:00
+++ edited/CREDITS	2004-06-17 12:14:42 +02:00
@@ -2,8 +2,8 @@
 	contributed to the Linux project.  It is sorted by name and
 	formatted to allow easy grepping and beautification by
 	scripts.  The fields are: name (N), email (E), web-address
-	(W), PGP key ID and fingerprint (P), description (D), and
-	snail-mail address (S).
+	(W), PGP key ID and fingerprint (P), description (D), an
+	hit-by-a-bus message (H), and snail-mail address (S).
 	Thanks,
 
 			Linus
@@ -3578,7 +3578,9 @@
 S: Germany
 
 N: Leonard N. Zubkoff
+H: Leonard was killed in a helicopter crash in Alaska on August 29, 2002
 W: http://www.dandelion.com/Linux/
+W: http://www.electricpenguin.com/filking/articles/zubkoff.html
 D: BusLogic SCSI driver
 D: Mylex DAC960 PCI RAID driver
 D: Miscellaneous kernel fixes
@@ -3599,6 +3601,6 @@
 
 # Don't add your name here, unless you really _are_ after Marc
 # alphabetically. Leonard used to be very proud of being the 
-# last entry, and he'll get positively pissed if he can't even
-# be second-to-last.  (and this file really _is_ supposed to be
-# in alphabetic order)
+# last entry, and he would get positively pissed if he knew he's
+# not even second-to-last any more.  (and this file really _is_
+# supposed to be in alphabetic order)

--=_porta-19605-1087467678-0001-2--
