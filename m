Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317547AbSGJRnw>; Wed, 10 Jul 2002 13:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317576AbSGJRnv>; Wed, 10 Jul 2002 13:43:51 -0400
Received: from mushroom.netcomsystems.com ([12.9.24.195]:22732 "EHLO
	exch-connector.netcomsystems.com") by vger.kernel.org with ESMTP
	id <S317547AbSGJRnu>; Wed, 10 Jul 2002 13:43:50 -0400
Message-ID: <629E717C12A8694A88FAA6BEF9FFCD440540BD@brigadoon.spirentcom.com>
From: "Perches, Joe" <joe.perches@spirentcom.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, thunder@ngforever.de
Cc: bunk@fs.tum.de, boissiere@adiglobal.com, linux-kernel@vger.kernel.org,
       "'Larry Kessler'" <kessler@us.ibm.com>,
       "'Martin.Bligh@us.ibm.com'" <Martin.Bligh@us.ibm.com>
Subject: RE: [STATUS 2.5]  July 10, 2002
Date: Wed, 10 Jul 2002 10:46:28 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While I understand the possible value, are printk translations
really important enough to justify?

Do we really need to have the equivalent of:
	printk(tr("Context string %s: %d"),tr("some string"),value);
translate/lookups?  Why?  If so, is this facility supposed to be
run-time or compile-time?

Unfortunately, I missed the RAS BOF at OLS, so I don't know
what was discussed.  Some of these were audio recorded.
Anyone know of the audio repository location?  Can't find any of
the 2001 or 2002 sessions on the symposium website.

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
The real issue is not breaking syslog parsers but to get 

-	Translations
etc

done in a way that doesnt make the kernel ugly. Thats non trivial. I need
to schedule a discussion with some IBM folks about part of this 
