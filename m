Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbULCRRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbULCRRv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbULCRPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:15:20 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:56469
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S262427AbULCRNI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:13:08 -0500
Date: Fri, 3 Dec 2004 12:22:14 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: USB DVD ... Again.
Message-ID: <20041203172214.GA28067@animx.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm about lost onthis one =)

----- Forwarded message from Alan Stern <stern@rowland.harvard.edu> -----

Date: Fri, 3 Dec 2004 10:22:43 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Wakko Warner <wakko@animx.eu.org>
cc: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] FWD: Re: USB DVD

On Thu, 2 Dec 2004, Wakko Warner wrote:

> I have the debug information at
> http://veg.animx.eu.org/usb-storage.debug.dvd.txt
> It's around 190kb in size.
> 
> ----- Forwarded message from Greg KH <greg@kroah.com> -----
> 
> Date:	Fri, 26 Nov 2004 19:28:17 -0800
> From: Greg KH <greg@kroah.com>
> To: linux-kernel@vger.kernel.org
> Subject: Re: USB DVD
> X-Mailing-List:	linux-kernel@vger.kernel.org
> 
> On Thu, Nov 25, 2004 at 10:03:13AM -0500, Wakko Warner wrote:
> > I have a USB DVD writer (I don't think the 'writer' part makes a difference)
> > that when I attempt to view a DVD Movie, it can't read some of the sectors
> > (DVD Auth I guess).  The same drive internally on ide works.  Is a problem
> > with USB or the enclosure?
> 
> Odds are it's the enclosure :)
> 
> But to be sure, can you enable CONFIG_USB_STORAGE_DEBUG and send the
> resulting log to the linux-usb-devel mailing list?

It's not a USB problem.  The device is returning an error code with sense 
key = 0x05 (Illegal Request) and ASC/ASCQ = 0x6f, 0x04 (I don't know what 
those mean).  Maybe someone who is familiar with the SCSI DVD protocol can 
explain.  However it's clear that the low-level USB transport is working 
without errors.

Alan Stern


----- End forwarded message -----
-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
