Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTDPSD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 14:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbTDPSD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 14:03:57 -0400
Received: from h002.c000.snv.cp.net ([209.228.32.66]:18420 "HELO
	c000.snv.cp.net") by vger.kernel.org with SMTP id S264536AbTDPSDy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 14:03:54 -0400
X-Sent: 16 Apr 2003 18:15:45 GMT
Message-ID: <001d01c30444$2fbd05b0$6901a8c0@athialsinp4oc1>
From: "Brien" <admin@brien.com>
To: "John Bradford" <john@grabjohn.com>
Cc: <linux-kernel@vger.kernel.org>
References: <200304161701.h3GH13Qv001204@81-2-122-30.bradfords.org.uk>
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro
Date: Wed, 16 Apr 2003 14:15:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've now tried running the following configurations
-both, with dual channel enabled @ 400
-both, with dual channel disabled @ 400
-both, with dual channel enabled @ 356
-both, with dual channel disabled @ 356
-both, with dual channel enabled @ 333
-both, with dual channel disabled @ 333
-one 400 @ 333 (A), with another module at @ 333 with dual channel disabled
-one 400 @ 333 (A), with another module at @ 333 with dual channel enabled
-one 400 @ 333 (B), with another module at @ 333 with dual channel disabled
-one 400 @ 333 (B), with another module at @ 333 with dual channel enabled
-two complete different modules, both DDR 333 @ 333 with dual channel
enabled
-two complete different modules, both DDR 333 @ 333 with dual channel
disabled
:::all of which are 512 MB each, and that the motherboard was tested to
support:::
and all of them have the same problem: black screen after kernel loads
they all do seem to test with errors when ran with another module, but they
also DO NOT test as errors when they're alone

I'm starting to think it's a problem with my motherboard rather than with
the RAM, because I've tried so many different ways and with different RAM
modules.. but I don't know for sure.. basically every time I try to run any
linux distribution, even if I type (mem=XXXM), it just doesn't work... I can
run some other operating systems without problems, but I know that e.g.
windows is less stressful etc.

hmm

----- Original Message -----
From: "John Bradford" <john@grabjohn.com>
To: "Brien" <admin@brien.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, April 16, 2003 1:01 PM
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro


> > The board supports up to 4 GB total (4 DIMM slots), DDR 400/333/266. I'm
> > normally using 2 * 512 MB DDR 400 on Single 128 bit mode. And the
board's
> > been tested to support up to 4 of the modules that I have (
> > KVR400X64C25/512 ) shown at :
> >
http://www.giga-byte.com/MotherBoard/Support/TechnologyGuide/TechnologyGuide
> > _63.htm
> >
> > motherboard link:
> >
http://www.giga-byte.com/MotherBoard/Products/Products_GA-SINXP1394(GA-8SQ80
> > 0%20Ultra2).htm
> >
> > I tested both modules seperately just minutes ago, AND GET NO ERRORS on
> > either one. The errors occur when I have both in.
> >
> > I've tried running them different speeds (e.g. 333), and it made no
> > difference in what Linux did (black screened after kernel load).
>
> Do you get errors with Memtest86, with both DIMMs installed, and set
> to run at 333?
>
> Also, try checking the power supply volatages are within spec.
>
> John.
>
>


