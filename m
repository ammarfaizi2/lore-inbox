Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269043AbRG3Rr2>; Mon, 30 Jul 2001 13:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269047AbRG3RrT>; Mon, 30 Jul 2001 13:47:19 -0400
Received: from atlrel1.hp.com ([156.153.255.210]:61651 "HELO atlrel1.hp.com")
	by vger.kernel.org with SMTP id <S269043AbRG3RrH>;
	Mon, 30 Jul 2001 13:47:07 -0400
Message-ID: <3B659DB8.42FECCEF@fc.hp.com>
Date: Mon, 30 Jul 2001 11:47:36 -0600
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <E15PtU8-0004cZ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox wrote:
> 
> > console is "Serial Port Console Redirection" (SPCR) table. This table
> > gives me almost all the information I need to initialize and use a
> > serial console. The bummer is this table was designed by Microsoft and
> > Microsoft owns the copyright on it. Microsoft primarily designed this
> > table for use by Whistler. Their copyright may cause potential problems
> > with using it in Linux. This makes me reluctant to use this table. I
> 
> Such as ?
> 
> If its a table that microsoft added to ACPI and its well thought out I don't
> see a big problem technically. There are a collection of BIOS services we
> use that were microsoft originated

I can not say this table is part of ACPI 2.0. ACPI 2.0 Spec document
lists SPCR in the DESCRIPTION_HEADER signatures but calls it Microsoft
Serial Port Console Redirection Table and refers to the URL on Microsoft
web site. If you go to this URL, you see the Microsoft copyright and
terms of use license. The same applies to DBGP (Debug Port Table).

-- 
Khalid

====================================================================
Khalid Aziz                              Linux Systems Operation R&D
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
