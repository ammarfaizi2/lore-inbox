Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbTE2Uy6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTE2Uy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:54:57 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:25827 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id S262830AbTE2Uy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:54:56 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Timothy Miller" <miller@techsource.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Bug reports: Making sure you provide all system info
Date: Thu, 29 May 2003 22:08:17 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAMECKECAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <3ED63ECB.9040705@techsource.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Timothy.

 > Is there a script people can run which will dig all necessary
 > system information out of /proc so that when one wants to report
 > a bug, they just run the script and dump the output into the
 > lkml email?
 >
 > I see lots of bug reports which provide very similar kinds of
 > information.  It seems to be so common a thing to do that it
 > should be automated, no?

Back in the 2.2 kernel days, there was a script called ver_linux
that did precisely that. It's still in 2.5.69 but nobody appears
to make use of it any more.

For reference, here's what the one in 2.5.69 produces for one of
my systems:

 Q> If some fields are empty or look unusual you may have an old version.
 Q> Compare to the current minimal requirements in Documentation/Changes.
 Q>
 Q> Linux Consulate.LAN.MemAlpha.Co.UK 2.2.14-e2c #5 Tue Jan 25 21:06:15
 Q>				GMT 2000 i586 unknown
 Q>
 Q> Gnu C                  egcs-2.91.66
 Q> Gnu make               3.78.1
 Q> binutils               2.9.5.0.22
 Q> util-linux             2.10f
 Q> mount                  2.10r
 Q> module-init-tools      /lib/modules/2.2.14-e2c/misc/appletalk.o
 Q> e2fsprogs              1.18
 Q> PPP                    2.3.11
 Q> Linux C Library        1.3.so
 Q> Dynamic linker (ldd)   2.1.3
 Q> Procps                 2.0.7
 Q> Net-tools              1.55
 Q> Console-tools          0.3.3
 Q> Sh-utils               2.0
 Q> Modules Loaded         slip slhc parport_pc lp parport tulip
 Q>				nls_iso8859-1 nls_cp437 vfat fat

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.484 / Virus Database: 282 - Release Date: 27-May-2003

