Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbTJBA4I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 20:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbTJBA4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 20:56:08 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:60680 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S262732AbTJBA4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 20:56:05 -0400
From: Michael Frank <mhf@linuxmail.org>
To: M?ns Rullg?rd <mru@users.sourceforge.net>
Subject: Re: [BUG?] SIS IDE DMA errors
Date: Thu, 2 Oct 2003 08:32:43 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <yw1x7k3vlokf.fsf@users.sourceforge.net> <yw1xy8w8uey3.fsf@users.sourceforge.net> <20030929100130.GA9322@ucw.cz>
In-Reply-To: <20030929100130.GA9322@ucw.cz>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310020832.43330.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 September 2003 18:01, Vojtech Pavlik wrote:
> On Mon, Sep 29, 2003 at 11:22:28AM +0200, M?ns Rullg?rd wrote:
> 
> > > 08 - 80-wire cables (needed for UDMA44 and higher) NOT installed.
> > >      FIFO threshold set to 3/4 for read and to 1/4 for write.
> > >
> > > 01 - IDE controller in compatibility mode. Native and test modes
> > >      disabled. (normal)
> > >
> > > e6 - PCI burst enable, EDB R-R pipeline enable, Fast postwrite enable,
> > >      device ID masqueraded as sis5513 (although real is 5517)
> > >      channels 0 and 1 enabled in normal mode
> > >
> > > 51 - Postwrite enabled on hda and hdc, prefetch on hda only
> > >
> > > 00 02 - 512 bytes prefetch size for hda
> > > 00 02 - 512 bytes prefetch size for hdc
> > >
> > > All this is OK, possibly except for the 80-wire cable not being present,
> > > but if this is a notebook, there might be a completely different cable
> > > type than what's standard, and the detection might not work there.
> > 
> > I've got no idea what the cable is like.  Is there anything to be
> > learned from opening the beast?  Anything in particular to look for?
> 

Notebook drive is plugged streight into a circuit board or connected by a 
short cable. The unlikely possibility for hardware is that it is out of spec 
and it also could be the drive. 

IBM/Hitachi have standalone PCDOS diagnostic floppy disk images and IIRC some
linux based stuff for their drives on their support website. You could run 
this diagnostics and see if you learn more. 

BTW, as it is in a way an  interrupt problem - you tried wo ACPI and  IIRC, 
you have no APIC?

Regards
Michael


