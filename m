Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270484AbTHLQFl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 12:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270486AbTHLQFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 12:05:41 -0400
Received: from fmr01.intel.com ([192.55.52.18]:38324 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S270484AbTHLQFZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 12:05:25 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [2.6.0-test3] Hyperthreading gone
Date: Tue, 12 Aug 2003 12:05:05 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FC33@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.0-test3] Hyperthreading gone
Thread-Index: AcNgKnoFh1i4frbBQbKaWWQpbf1HjgAv2/JA
From: "Brown, Len" <len.brown@intel.com>
To: "Hugh Dickins" <hugh@veritas.com>,
       "Grover, Andrew" <andrew.grover@intel.com>
Cc: "Florian Weimer" <fw@deneb.enyo.de>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Aug 2003 16:05:18.0838 (UTC) FILETIME=[869AD160:01C360EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh,
My changes go to Marcelo via Andy.  This one has been waiting in his
staging area while he was out on vacation.  Now that he is back --
unless something broke in his tree -- I assume he'll be sending it along
to Marcelo shortly.

Cheers,
-Len

Ps. If you'd like to see the code, here it is:
Andy's tree:
http://linux-acpi.bkbits.net:8080/linux-acpi-2.4
Len's tree:
http://linux-acpi.bkbits.net:8080/to-andy-2.4

Pps. Feel free to use my intel e-mail account -- I use my yahoo account
mostly to reduce spam so I don't read it every day.

> -----Original Message-----
> From: Hugh Dickins [mailto:hugh@veritas.com] 
> Sent: Monday, August 11, 2003 12:53 PM
> To: Len Brown
> Cc: Florian Weimer; Grover, Andrew; Marcelo Tosatti; 
> linux-kernel@vger.kernel.org
> Subject: Re: [2.6.0-test3] Hyperthreading gone
> 
> 
> Hi Len,
> 
> On Sun, 10 Aug 2003, Florian Weimer wrote:
> > Greg Norris <haphazard@kc.rr.com> writes:
> > 
> > > Did you select CPU Enumeration Only, or "normal" ACPI?
> > 
> > CPU Enumeration Only.
> > 
> > > If the former, did you specify the "acpismp=force" parameter at
> > > bootup?
> > 
> > I didn't.  Previous experience (with some 2.5.x versions) indicates
> > that Linux does not support full ACPI on this machine.  The
> > documentation suggests that the command line option enables 
> full ACPI,
> > so I hesitate to do this.
> 
> Florian, at the moment, in 2.4 and in 2.6, you do have to specify the
> "acpismp=force" boot parameter to get HT to work with CPU Enumeration
> Only: it can't enable full ACPI since you don't have full 
> ACPI built in,
> so no need to hesitate.  But of course it's stupid, and the ACPI guys
> agree it's wrong and to be fixed.
> 
> Len, what's up with this?  I'm not worried about 2.6 right now, but
> 4 weeks ago you were about to submit a patch to fix this for 2.4.22,
> which is now at 2.4.22-rc2 and still behaving as broken in -pre1.
> 
> Is it time to dig out my own patch and send to Marcelo again?
> 
> Hugh
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
