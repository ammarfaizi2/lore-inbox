Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbTKUAgP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 19:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbTKUAgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 19:36:15 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:47053 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263008AbTKUAgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 19:36:14 -0500
Date: Thu, 20 Nov 2003 16:35:09 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Hanna Linder <hannal@us.ibm.com>, Greg KH <greg@kroah.com>,
       Martin Schlemmer <azarah@nosferatu.za.org>,
       Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       mochel@osdl.org
Subject: Re: driver model for inputs
Message-ID: <71490000.1069374909@w-hlinder>
In-Reply-To: <20031120235410.GB431@elf.ucw.cz>
References: <20031119213237.GA16828@fs.tum.de> <20031119221456.GB22090@kroah.com> <1069283566.5032.21.camel@nosferatu.lan> <20031119232651.GA22676@kroah.com> <20031120125228.GC432@openzaurus.ucw.cz> <20031120170303.GJ26720@kroah.com>
 <20031120222825.GE196@elf.ucw.cz> <55080000.1069368524@w-hlinder> <20031120225504.GG196@elf.ucw.cz> <56710000.1069370317@w-hlinder> <20031120235410.GB431@elf.ucw.cz>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, November 21, 2003 12:54:10 AM +0100 Pavel Machek <pavel@ucw.cz> wrote:

> 
> [Snip snip; most of patch seems to be moving from something.dev to
> something-> dev]

To take advantage of the internal kobject reference counting. The main
changes are the registering and unregistering of class objects which gives
the input class and devices in the sysfs tree.

> 
> This seems to deal with udev aspect of the problem... Do you have any
> ideas have powermanagment fits into the picture? I need a way to hook
> suspend() and resume() methods, so that I can fix keyboard/mouse after
> sleep.
> 								Pavel

I dont know much about the power management stuff yet. Pat or Greg could
probably tell you more than I can.

Hanna

