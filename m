Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266721AbSKOVTe>; Fri, 15 Nov 2002 16:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266733AbSKOVTe>; Fri, 15 Nov 2002 16:19:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16914 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266721AbSKOVTc>; Fri, 15 Nov 2002 16:19:32 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: lan based kgdb
Date: Fri, 15 Nov 2002 21:26:00 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ar3op8$f20$1@penguin.transmeta.com>
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay>
X-Trace: palladium.transmeta.com 1037395579 414 127.0.0.1 (15 Nov 2002 21:26:19 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 15 Nov 2002 21:26:19 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <334960000.1037397999@flay>,
Martin J. Bligh <mbligh@aracnet.com> wrote:
>> Is there a source level remote kernel debugger that
>> communicates over an ethernet interface? The debugger
>> kgdb from kgdb.sourceforge.net works only with serial port.
>
>A cheap terminal server might work ...

Well, apart from the fact that a lot of machines don't even _have_
serial ports..

I dunno. I might even be willing to apply kgdb patches to my tree if it
just could use the regular network card I already have connected on all
my machines. None of my laptops have a serial line, for example, but
they all have networking.

Soon even _desktops_ probably won't have serial lines any more, only USB.

		Linus

