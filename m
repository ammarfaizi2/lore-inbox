Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbULGVnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbULGVnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 16:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbULGVnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 16:43:23 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:27803
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S261635AbULGVnR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 16:43:17 -0500
Date: Tue, 7 Dec 2004 16:51:45 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Doug Maxey <dwm@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB DVD ... Again.
Message-ID: <20041207215145.GA5259@animx.eu.org>
Mail-Followup-To: Doug Maxey <dwm@austin.ibm.com>,
	linux-kernel@vger.kernel.org
References: <20041203172214.GA28067@animx.eu.org> <200412031750.iB3Hot3q002538@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412031750.iB3Hot3q002538@falcon10.austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Maxey wrote:
> 
> On Fri, 03 Dec 2004 12:22:14 EST, Wakko Warner wrote:
> >I'm about lost onthis one =)
> >
> >----- Forwarded message from Alan Stern <stern@rowland.harvard.edu> -----
> >
> >Date: Fri, 3 Dec 2004 10:22:43 -0500 (EST)
> >From: Alan Stern <stern@rowland.harvard.edu>
> >To: Wakko Warner <wakko@animx.eu.org>
> >cc: linux-usb-devel@lists.sourceforge.net
> >Subject: Re: [linux-usb-devel] FWD: Re: USB DVD
> >
> >It's not a USB problem.  The device is returning an error code with sense 
> >key = 0x05 (Illegal Request) and ASC/ASCQ = 0x6f, 0x04 (I don't know what 
> >those mean).  Maybe someone who is familiar with the SCSI DVD protocol can 
> >explain.  However it's clear that the low-level USB transport is working 
> >without errors.
> >
> >Alan Stern
> 
> Official definition:
> 6F/04 - MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION
> 
> 05 - Illegal Request
> 
> Means that a value was set in the cdb to do an operation the drive could 
> not handle.

So I guess it is the usb enclosure or the usb subsystem is doing something
wrong.  The drive works fine when attached internally or I use a
non-encrypted dvd..

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
