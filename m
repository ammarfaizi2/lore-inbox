Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289198AbSANLSr>; Mon, 14 Jan 2002 06:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289197AbSANLSh>; Mon, 14 Jan 2002 06:18:37 -0500
Received: from albatross-ext.wise.edt.ericsson.se ([194.237.142.116]:9127 "EHLO
	albatross-ext.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S289196AbSANLSU>; Mon, 14 Jan 2002 06:18:20 -0500
Message-ID: <F50839283B51D211BC300008C7A4D63F0C10759D@eukgunt002.uk.eu.ericsson.se>
From: "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>
To: "'esr@thyrsus.com'" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: RE: ISA hardware discovery -- the elegant solution
Date: Mon, 14 Jan 2002 12:17:58 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Eric S. Raymond [mailto:esr@thyrsus.com]
> Subject: ISA hardware discovery -- the elegant solution
> 
> 
> I've been thinking about the hardware-discovery problem for 
> ISA devices,
> and there may be an elegant solution.  It will take a number 
> of small changes
> to the kernel sources, however.
> 
> The kernel's device drivers have, of course, to include probe
> routines, and those hard-compiled in typically log the presence of
> their hardware to /var/log/mesg when it loads.  By scanning that
> file, we in effect get to use those probes.

Doesn't this mean that you would need a fully functional kernel
before you get to run the autoconfigurator?

Michael
