Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268829AbTBZRPQ>; Wed, 26 Feb 2003 12:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268830AbTBZRPQ>; Wed, 26 Feb 2003 12:15:16 -0500
Received: from mms1.broadcom.com ([63.70.210.58]:23308 "EHLO mms1.broadcom.com")
	by vger.kernel.org with ESMTP id <S268829AbTBZRPK>;
	Wed, 26 Feb 2003 12:15:10 -0500
From: "Kimball Brown" <kimball@serverworks.com>
To: "Alan Cox" <alan@redhat.com>, davej@codemonkey.org.uk
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: RE: Tighten up serverworks workaround.
Date: Wed, 26 Feb 2003 09:27:26 -0800
Message-ID: <OMEEJAEPHFDBEBPLINBDCELACNAA.kimball@serverworks.com>
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <200302261636.h1QGaAv21387@devserv.devel.redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-WSS-ID: 124227E4376257-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How can e help?  Please give me a configuration and how the bug manifests
inself.

Kim Brown
VP, Business Development
kimball@serverworks.com
2451 Mission College Blvd
Santa Clara, CA 95054
(408)922-3174
(408)799-3500 (Mobile)
(408)922-3192 (FAX)

-----Original Message-----
From: Alan Cox [mailto:alan@redhat.com]
Sent: Wednesday, February 26, 2003 8:36 AM
To: davej@codemonkey.org.uk
Cc: alan@redhat.com; torvalds@transmeta.com; linux-kernel@vger.kernel.org
Subject: Re: Tighten up serverworks workaround.

> I've reports of people with rev6's who have reported success
> with that workaround commented out.  Could be they never
> pushed the machine hard enough to trigger a bug, but I'd
> have thought this breakage would show up pretty quickly.

It doesn't. It requires the right patterns and took Dell quite
some time to identify and pin down. If its like the 450NX one
which I suspect it is then you have to have pending misordered
stores to a write gathering target evicted by another read.

> My attempts to contact serverworks in the past have fallen on
> deaf ears. maybe you have better luck ?

I'll try. I got on ok with them for the OSB4 stuff but thats
a long time ago and they've been eaten since then

[Bcc'd to the person I suspect is the right starting point]

Alan


