Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbWIEOcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWIEOcP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 10:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWIEOcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 10:32:15 -0400
Received: from alnrmhc12.comcast.net ([206.18.177.52]:48540 "EHLO
	alnrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965018AbWIEOcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 10:32:13 -0400
Subject: Re: [OLPC-devel] Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM
	Improvements
From: Jim Gettys <jg@laptop.org>
Reply-To: jg@laptop.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       "Brown, Len" <len.brown@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org
In-Reply-To: <20060904130933.GC6279@ucw.cz>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>
	 <20060830194317.GA9116@srcf.ucam.org>
	 <200608311713.21618.bjorn.helgaas@hp.com>
	 <1157070616.7974.232.camel@localhost.localdomain>
	 <20060904130933.GC6279@ucw.cz>
Content-Type: text/plain
Organization: OLPC
Date: Tue, 05 Sep 2006 10:31:50 -0400
Message-Id: <1157466710.6011.262.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-04 at 13:09 +0000, Pavel Machek wrote:

> 
> 2.4 and 2.6 are *very* different here. You'll probably need to optimize freezer
> in 2.6 a bit...
> 						

Among other problems: e.g. 2.4 did not automatically do a VT switch; 2.6
does; we'll have to have a way to signal "we're a sane display driver;
don't switch away from me on suspend".
                                 - Jim

-- 
Jim Gettys
One Laptop Per Child


