Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286692AbSANO1F>; Mon, 14 Jan 2002 09:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286672AbSANO0t>; Mon, 14 Jan 2002 09:26:49 -0500
Received: from albatross-ext.wise.edt.ericsson.se ([194.237.142.116]:39300
	"EHLO albatross-ext.wise.edt.ericsson.se") by vger.kernel.org
	with ESMTP id <S286692AbSANO0J>; Mon, 14 Jan 2002 09:26:09 -0500
Message-ID: <F50839283B51D211BC300008C7A4D63F0C1075A2@eukgunt002.uk.eu.ericsson.se>
From: "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>
To: "'Giacomo Catenazzi'" <cate@debian.org>
Cc: "'esr@thyrsus.com'" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: RE: ISA hardware discovery -- the elegant solution
Date: Mon, 14 Jan 2002 15:25:50 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Giacomo Catenazzi [mailto:cate@debian.org]
> >>
> >>The kernel's device drivers have, of course, to include probe
> >>routines, and those hard-compiled in typically log the presence of
> >>their hardware to /var/log/mesg when it loads.  By scanning that
> >>file, we in effect get to use those probes.
> >>
> > 
> > Doesn't this mean that you would need a fully functional kernel
> > before you get to run the autoconfigurator?
> 
> 
> Not a problem. Autoconfiguration is made to help configuring
> the kernel, before to compile it. So you need a linux working
> machine (actually you can cross-compile).
> 
> Our task is to allow user to compile a kernel, with the
> needed drivers, without the non used drivers.

OK, well I guess I am a little confused.

If I hit an autoconfigurator button then I would expect a kernel that
will boot and know everything there is to know about my machine.

Without probing the hardware how will the autoconfigurator cope with 
the hardware changing underneath it?

Michael
