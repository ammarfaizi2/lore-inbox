Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268050AbTBNVD1>; Fri, 14 Feb 2003 16:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268048AbTBNVDF>; Fri, 14 Feb 2003 16:03:05 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57728
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268037AbTBNVCP>; Fri, 14 Feb 2003 16:02:15 -0500
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Rusty Lynch <rusty@linux.co.intel.com>,
       lkml <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Daniel Pittman <daniel@rimspace.net>
In-Reply-To: <20030213230408.GA121@elf.ucw.cz>
References: <1045106216.1089.16.camel@vmhack>
	 <1045160506.1721.22.camel@vmhack>  <20030213230408.GA121@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045260726.1854.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Feb 2003 22:12:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-13 at 23:04, Pavel Machek wrote:
> Hi!
> 
> > temperature (RO)
> >   - show: prints temperature in degrees farenheit
> 
> Please, use degrees celsius to keep it consistent with ACPI and
> lm-sensors.

The ioctl interface is farenheit and has been since before Linux 2.0
That may not have been smart but we are stuck with it there at
least.

