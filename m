Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291106AbSBLPZa>; Tue, 12 Feb 2002 10:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291110AbSBLPZU>; Tue, 12 Feb 2002 10:25:20 -0500
Received: from [199.203.178.211] ([199.203.178.211]:53943 "EHLO
	exchange.store-age.com") by vger.kernel.org with ESMTP
	id <S291106AbSBLPZM> convert rfc822-to-8bit; Tue, 12 Feb 2002 10:25:12 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
content-class: urn:content-classes:message
Subject: RE: Linux console at boot
MIME-Version: 1.0
Content-Type: text/plain;
	charset="x-user-defined"
Content-Transfer-Encoding: 8BIT
Date: Tue, 12 Feb 2002 17:25:05 +0200
Message-ID: <DCC3761A6EC31643A3BAF8BB584B26CC0AAE55@exchange.store-age.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux console at boot
Thread-Index: AcGz2Idr/H/rnDR1SLGyfz2bh+xAZQAAIi7Q
From: "Alexander Sandler" <ASandler@store-age.com>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: "Linux Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> > > Is there any way to stop the console scrolling during 
> boot? My reason
> > > for this is I am trying to troubleshoot a boot problem with
> > > 2.4.18-pre7 and I would like to give a more useful report than "it
> > > won't boot" but the screen outputs information every few 
> seconds and I
> > > can't "freeze" the display so I can copy down the initial 
> error(s).
> > >
> > > This is an Intel unit using the standard console (not 
> serial console).
> > > pre7 will not boot but pre6 boots every time.

You may try to make to make a system to sleep for a while (until you'll
press something for instance) from the initrd image. Take a look at the
Documentation/initrd.txt (???).
Depending on the message you are interested to see, this should help.

Alexandr Sandler.
