Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269351AbRGaQYB>; Tue, 31 Jul 2001 12:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269350AbRGaQXv>; Tue, 31 Jul 2001 12:23:51 -0400
Received: from archive.osdlab.org ([65.201.151.11]:42437 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S269349AbRGaQXi>;
	Tue, 31 Jul 2001 12:23:38 -0400
Message-ID: <3B66DAE4.54937826@osdlab.org>
Date: Tue, 31 Jul 2001 09:20:52 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Khalid Aziz <khalid@fc.hp.com>
CC: Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <200107302240.f6UMeWg2001230@webber.adilger.int> <31754.996543218@kao2.melbourne.sgi.com> <20010730215002.I1275@valinux.com> <3B66D9B9.A01685AB@fc.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Khalid Aziz wrote:
> 
> We are moving slightly off of my original question which still stands.
> For machines that do have serial ports but not at legacy addresses
> (COM1, COM2,....), is it acceptable to use the description of these
> ports as provided by SPCR and DBGP tables even though Microsoft claims
> copyright on these tables and retains the option to modify these tables
> at any time? Would it be preferable to use a table defined as part of a
> standard like ACPI 2.0 or DIG64 (such a table does not exist at this
> time but with enough votes for it, it may be added)?

We already use other MS-defined tables and specs, like the
$PIR interrupt routing table.

Alan implemented the Simple Boot Flag Protocol in 2.4.5(?)-ac,
which is also from www.microsoft.com.

There are other ACPI-like tables that probably need to be
used for NUMA machines that are defined/specified only at
microsoft.com.

IOW, these represent "de facto" industry specs (I hesitate
to say "standards"), so use them.

-- 
~Randy
