Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310682AbSCHFUB>; Fri, 8 Mar 2002 00:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310683AbSCHFTv>; Fri, 8 Mar 2002 00:19:51 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:62953 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S310682AbSCHFTh>; Fri, 8 Mar 2002 00:19:37 -0500
From: "Buddy Lumpkin" <blumpkin@attbi.com>
To: "Thomas Molina" <tmolina@cox.net>, <linux-kernel@vger.kernel.org>
Subject: RE: Invalid @home email addresses
Date: Thu, 7 Mar 2002 21:16:14 -0800
Message-ID: <FJEIKLCALBJLPMEOOMECGECOCJAA.blumpkin@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44.0203022258360.21225-100000@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the Seattle area, all of these addresses were moved to the attbi.com
domain.

In fact, I never heard anything about cox.com, didn't AT&T buy @home? I know
they have since sold it but my email address hasn't changed again.

--Buddy

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Thomas Molina
Sent: Saturday, March 02, 2002 9:18 PM
To: linux-kernel@vger.kernel.org
Subject: Invalid @home email addresses


On 1 March 02 cox@home switched their services from infrastructure hosted
on hardware by Excite to "native" hardware.  All @home.com addresses are
now invalid.  Grepping through the source for these invalid addresses
produced the following:

drivers/net/de4x5.c 	mmporter@home.com
drivers/scsi/megaraid.c 	johnsom@home.com
drivers/scsi/ppa.h	johncavan@home.com
drivers/scsi/imm.h	johncavan@home.com
drivers/sound/aci.c	pellicci@home.com
drivers/media/video/bttv-cards.c	daniel.herrington@home.com

Most addresses for home.com users simply switched to cox.net addresses.
However, email to the above users at cox.net bounced in four out of five
cases.  I am posting here in hopes that theses users are still on the
mailing list and will respond.  If no response is received I would like to
submit a patch adding comments to the source code indicating the addresses
are no longer valid and no new email addresses are known.

Note:  The above addresses also exist in the 2.5 tree.  I also intend to
submit a patch for the comments in the 2.5 tree.  Following is a patch to
correct my email address in the 2.4 tree.  This patch is against 2.4.18.

diff -urN linux.old/CREDITS linux.new/CREDITS
--- linux.old/CREDITS	Sat Mar  2 21:33:52 2002
+++ linux.new/CREDITS	Sat Mar  2 22:51:09 2002
@@ -2113,7 +2113,7 @@
 S: Germany

 N: Thomas Molina
-E: tmolina@home.com
+E: tmolina@cox.net
 D: bug fixes, documentation, minor hackery

 N: David Mosberger-Tang
diff -urN linux.old/Documentation/sound/PAS16
linux.new/Documentation/sound/PAS16
--- linux.old/Documentation/sound/PAS16	Wed Apr 11 20:02:27 2001
+++ linux.new/Documentation/sound/PAS16	Sat Mar  2 22:52:11 2002
@@ -1,7 +1,7 @@
 Pro Audio Spectrum 16 for 2.3.99 and later
 =========================================
-by Thomas Molina (tmolina@home.com)
-last modified 3 Mar 2001
+by Thomas Molina (tmolina@cox.net)
+last modified 2 Mar 2002
 Acknowledgement to Axel Boldt (boldt@math.ucsb.edu) for stuff taken
 from Configure.help, Riccardo Facchetti for stuff from README.OSS,
 and others whose names I could not find.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

