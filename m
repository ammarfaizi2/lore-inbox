Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135795AbRDTETo>; Fri, 20 Apr 2001 00:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135796AbRDTETf>; Fri, 20 Apr 2001 00:19:35 -0400
Received: from mail.mesatop.com ([208.164.122.9]:22799 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S135795AbRDTETY>;
	Fri, 20 Apr 2001 00:19:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: Re: Configure.help maintainer change
Date: Thu, 19 Apr 2001 22:18:32 -0600
X-Mailer: KMail [version 1.2]
Cc: esr@thyrsus.com, alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Message-Id: <01041922183200.01327@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Boldt wrote:
>Eric has worked on Configure.help for some time now and I haven't,
>so he will take over official maintenance of that file.

I've also been fixing up Configure.help for a while now, and helped Eric
recently with his huge update patch for Configure.help.

I'd like to be listed as a co-maintainer of Configure.help, along with ESR.

Steven

Here is an alternative patch, against 2.4.3-ac10:

--- linux/MAINTAINERS.ac10      Thu Apr 19 21:54:37 2001
+++ linux/MAINTAINERS   Thu Apr 19 22:00:06 2001
@@ -280,8 +280,10 @@
 S:     Maintained
 
 CONFIGURE.HELP
-P:     Axel Boldt
-M:     axel@uni-paderborn.de
+P:     Eric S. Raymond
+M:     Eric S. Raymond <esr@thyrsus.com>
+P:     Steven P. Cole
+M:     Steven P. Cole <elenstev@mesatop.com>
 S:     Maintained
 
 COSA/SRP SYNC SERIAL DRIVER
--- linux/Documentation/Configure.help.ac10     Thu Apr 19 22:01:20 2001
+++ linux/Documentation/Configure.help  Thu Apr 19 22:02:58 2001
@@ -1,4 +1,5 @@
-# Maintained by Axel Boldt (axel@uni-paderborn.de)
+# Maintained by Eric S. Raymond <esr@thyrsus.com>
+# and by Steven P. Cole <elenstev@mesatop.com>
 #
 # This version of the Linux kernel configuration help texts
 # corresponds to the kernel versions 2.4.x.
