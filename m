Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266796AbSKOVd6>; Fri, 15 Nov 2002 16:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266804AbSKOVd6>; Fri, 15 Nov 2002 16:33:58 -0500
Received: from [216.116.109.69] ([216.116.109.69]:19017 "EHLO
	exchange55.in-inc.com") by vger.kernel.org with ESMTP
	id <S266796AbSKOVd5>; Fri, 15 Nov 2002 16:33:57 -0500
Message-ID: <88217E398B02EB40ABA53F071BECA8450A83DE@exchange55.in-inc.com>
From: Edwin Bland <EdwinB@in-inc.com>
To: "'torvalds@transmeta.com'" <torvalds@transmeta.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: lan based kgdb
Date: Fri, 15 Nov 2002 13:44:23 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Anything that can help with source level debugging of custom drivers
would be great for bringing up new hardware.   
One of my frustrations with debugging a driver on a StrongARM based platform
has been that I don't know of a way to step through the code other than a
post-mortem review of the printk's.
	An ethernet interface would be great, like the existing gdb
interface for cross-platform development.

Edwin Bland,



-----Original Message-----
From: torvalds@transmeta.com [mailto:torvalds@transmeta.com]
Sent: Friday, November 15, 2002 1:26 PM
To: linux-kernel@vger.kernel.org
Subject: Re: lan based kgdb


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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
