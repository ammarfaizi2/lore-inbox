Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287421AbSAHRT5>; Tue, 8 Jan 2002 12:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288190AbSAHRTs>; Tue, 8 Jan 2002 12:19:48 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:49671 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S287421AbSAHRTj> convert rfc822-to-8bit; Tue, 8 Jan 2002 12:19:39 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: PATCH 2.5.2-pre9 scsi cleanup
Date: Tue, 8 Jan 2002 11:19:32 -0600
Message-ID: <45B36A38D959B44CB032DA427A6E10640167CF1C@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH 2.5.2-pre9 scsi cleanup
Thread-Index: AcGYZSwse8r6KGVZTnycDSS8xCQo/QAAd61g
From: "Cameron, Steve" <Steve.Cameron@COMPAQ.com>
To: "Martin Dalecki" <dalecki@evision-ventures.com>
Cc: <linux-kernel@vger.kernel.org>,
        "White, Charles" <Charles.White@COMPAQ.com>
X-OriginalArrivalTime: 08 Jan 2002 17:19:34.0078 (UTC) FILETIME=[A421BDE0:01C19868]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki [mailto:dalecki@evision-ventures.com] wrote,
regarding removal of scsi_device_types[] from drivers/scsi/scsi.c

> Cameron, Steve wrote:
[...]
> >Hmmm, I was using that.... (In, for example, 
> >the cciss patch here: http://www.geocities.com/smcameron 
> >It's not any big deal, though.)
> >
> Precisely this "not any big deal" is the point: It was the wrong 
> approach to a trivial problem ;-).

So what's the right approach?  I can invent my own easily enough, 
but each driver doing its own thing doesn't seem right.  I assumed 
that it was in scsi.c foi common usage, so each driver that wanted 
to say, use these device type strings in diagnostic messages or 
some such wouldn't have to reinvent this wheel, and so all the 
drivers would consistently use the same names.  Will it be 
replaced with something else?

Just want to know so I don't waste (even more :-) time 
doing something dumb.

Thanks,

-- steve
