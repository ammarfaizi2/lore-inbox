Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318066AbSHHX3t>; Thu, 8 Aug 2002 19:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318071AbSHHX3t>; Thu, 8 Aug 2002 19:29:49 -0400
Received: from h-66-134-202-172.SNVACAID.covad.net ([66.134.202.172]:65465
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318066AbSHHX3s>; Thu, 8 Aug 2002 19:29:48 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 8 Aug 2002 16:33:20 -0700
Message-Id: <200208082333.QAA11560@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: USBLP_WRITE_TIMEOUT too short for Kyocera FS-1010.
Cc: linux-usb-devel@lists.sourceforge.net, mjr@znex.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark J Roberts writes:
>Printing complicated postscript documents makes my Kyocera FS-1010
>hit that timeout. I increased it to 240 seconds and the problem
>seems to have disappeared.
>
>I guess there ought to be a blacklist or something.

	I saw a similar thing a few weeks ago (under 2.5.27?) with the
Hewlett-Packard 656C ink jet printer, which only occurred when I would
send a page with images on it, so the printer really would need a long
time before it was ready to accept more data.

	I would hope that the kernel should be able to wait as long
as the printer wants before the printer indicates that it is ready for
more data.  I don't know if this is a bug in these printers' USB
implementations or if it is a real kernel bug.  I just haven't had
time to investigate it yet (and I no longer have access to that printer,
although 656C's are only $30 at Fry's).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
