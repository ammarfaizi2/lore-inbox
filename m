Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264938AbTFQWCU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbTFQWCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:02:19 -0400
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:37094 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id S264938AbTFQWCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:02:11 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Sam Ravnborg" <sam@ravnborg.org>,
       "Linus Torvalds" <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kbuild: Document lib-y
Date: Tue, 17 Jun 2003 23:16:15 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAEEOBEFAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030608180113.GA3987@mars.ravnborg.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam.

 > Hi Linus, documentation for the newly added lib-y.

Minor grammatical tweaks to the same...

 > ===== Documentation/kbuild/makefiles.txt 1.8 vs edited =====
 > --- 1.8/Documentation/kbuild/makefiles.txt	Sun Mar 16 06:52:28 2003
 > +++ edited/Documentation/kbuild/makefiles.txt	Sun Jun  8 
 > @@ -214,20 +214,33 @@
 >  	modules exporting symbols.
 >  	See also Documentation/modules.txt.
 >  
 > ---- 3.5 Library file goals - L_TARGET
 > +--- 3.5 Library file goals - lib-y
 >  
 > -	Instead of building a built-in.o file, you may also
 > -	build an archive which again contains objects listed in $(obj-y).
 > -	This is normally not necessary and only used in lib/ and 
 > -	arch/$(ARCH)/lib directories.
 > -	Only the name lib.a is allowed.
 > +	Objects listed with obj-* is used for modules or
                                ^^
That should be "are" ?

 > +	are combined in a built-in.o for that specific directory.
      ^^^
That shouldn't be there.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.490 / Virus Database: 289 - Release Date: 16-Jun-2003

