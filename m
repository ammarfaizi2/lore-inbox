Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbTE3WzH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 18:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbTE3WzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 18:55:07 -0400
Received: from netmail01.services.quay.plus.net ([212.159.14.219]:18641 "HELO
	netmail01.services.quay.plus.net") by vger.kernel.org with SMTP
	id S264002AbTE3WzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 18:55:06 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Linus Torvalds" <torvalds@transmeta.com>,
       =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: "Steven Cole" <elenstev@mesatop.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
Date: Sat, 31 May 2003 00:08:32 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAEEGBECAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <Pine.LNX.4.44.0305301431390.2671-100000@home.transmeta.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

 > The motivation for doing the ANSI-fication is just that there
 > is now a sanity checker tool that will complain loudly about
 > bad typing, and since I wrote it and I hate old-style K&R
 > sources, it doesn't parse them. 

Probably the simplest solution is to make the said tool recognise
a line like...

	#pragma KandR

...and have it abort any file where it finds that line with some
sort of warning, perhaps along the lines of...

	SanityCheck: Found K&R pragma, ignoring kernel/foobar.c

...or something similar. It would then be simply a case of adding
the said line near the top of whichever source files are still in
K&R format.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.484 / Virus Database: 282 - Release Date: 27-May-2003

