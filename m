Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267049AbSKWTSZ>; Sat, 23 Nov 2002 14:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbSKWTSY>; Sat, 23 Nov 2002 14:18:24 -0500
Received: from 3-238.ctame701-2.telepar.net.br ([200.181.171.238]:33796 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267049AbSKWTSV>; Sat, 23 Nov 2002 14:18:21 -0500
Date: Sat, 23 Nov 2002 15:02:29 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       aris@cathedrallabs.org, acpi-devel@lists.sourceforge.net
Subject: [PATCHES] convert acpi to seq_file
Message-ID: <20021123170229.GF25766@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	aris@cathedrallabs.org, acpi-devel@lists.sourceforge.net
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A50E@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A50E@orsmsx119.jf.intel.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 14, 2002 at 02:34:35PM -0800, Grover, Andrew escreveu:
> > From: Arnaldo Carvalho de Melo [mailto:acme@conectiva.com.br] 
> > 	Please consider pulling from:
> > 
> > bk://oops.kerneljanitors.org:acpi-2.5
> > 
> > 	This is the first in a series of changesets converting
> > ACPI to seq_file, please lets us know if something is unacceptable.
> > 
> > 	The work was done by Aristeu Rozanski.
> 
> Hi acme,
> 
> Looks like an improvement. My thanks to you and Aristeu.
> 
> Let me know when you're done with all the changesets and I'll pull
> everything.

Andrew,

	Sorry for the delay, now you can pull all from:

bk://oops.kerneljanitors.org:acpi-2.5

or 

master.kernel.org:/home/acme/BK/acpi-2.5

Here is a summary of what was done:

ChangeSet@1.864, 2002-11-23 14:34:10-02:00, aris@cathedrallabs.org
  o acpi: convert drivers/acpi/toshiba_acpi.c to seq_file

ChangeSet@1.863, 2002-11-23 14:20:41-02:00, aris@cathedrallabs.org
  o acpi: convert drivers/acpi/thermal.c

ChangeSet@1.862, 2002-11-23 14:13:27-02:00, acme@conectiva.com.br
  o acpi/processor.o: fix up seq_file conversion, add missing comma

ChangeSet@1.861, 2002-11-23 13:57:42-02:00, aris@cathedrallabs.org
  o acpi: convert drivers/acpi/sleep.c to seq_file

ChangeSet@1.860, 2002-11-23 13:45:39-02:00, aris@cathedrallabs.org
  o acpi: convert drivers/acpi/processor.c to seq_file

ChangeSet@1.859, 2002-11-23 13:37:09-02:00, aris@cathedrallabs.org
  o acpi: convert drivers/acpi/power.c to seq_file

ChangeSet@1.805.15.3, 2002-11-15 05:43:42-02:00, aris@cathedrallabs.org
  o acpi: convert drivers/acpi/button.c to seq_file

ChangeSet@1.805.15.1, 2002-11-13 19:35:45-02:00, aris@cathedrallabs.org
  drivers/acpi/ac.c: convert to seq_file


Best Regards,

- Arnaldo
