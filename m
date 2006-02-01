Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWBAOnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWBAOnd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 09:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWBAOnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 09:43:33 -0500
Received: from host27-37.discord.birch.net ([65.16.27.37]:16537 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932457AbWBAOnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 09:43:33 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: <sander@humilis.net>
Cc: "'Lennart Sorensen'" <lsorense@csclub.uwaterloo.ca>,
       <linux-kernel@vger.kernel.org>, <jgarzik@pobox.com>
Subject: RE: [OT] 8-port AHCI SATA Controller?
Date: Wed, 1 Feb 2006 08:53:57 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20060201101504.GC14960@favonius>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcYnF28zLSLuEgaySJWGL3lXnGCGGAAJkskQ
Message-ID: <EXCHG2003yD7TfSr0fV00001104@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 01 Feb 2006 14:36:53.0432 (UTC) FILETIME=[F1C41B80:01C6273C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Sander [mailto:sander@humilis.net] 
> Sent: Wednesday, February 01, 2006 4:15 AM
> To: Roger Heflin
> Cc: 'Lennart Sorensen'; 'Sander'; 
> linux-kernel@vger.kernel.org; jgarzik@pobox.com
> Subject: Re: [OT] 8-port AHCI SATA Controller?
> 
> Roger Heflin wrote (ao):
> > Highpoint has some that I believe are software raidish.
> > 
> > They do have on-board parity generators that are used when you use 
> > there binary only modules.
> > 
> > I have heard that they will work with later kernels (2.6.15+) since 
> > the highpoint are a standard Marvell chipset, and they seem to be 
> > fairly price competitive with JBOD raid controllers, and have some 
> > controllers that have more than 8 ports, the price per port may be 
> > better on the larger controllers.
> 
> Thanks for the tip. I'll do some research on the Highpoint 
> controllers.
> 
> 	Kind regards, Sander

Something important to note, if you need to use highpoints binary
driver (ie the one in the kernel is not quite working yet) - then you
will need to run a 2.6.13 or earlier kernel, their driver has some
issue with 2.6.14+ they are working on it.

I believe this also holds true of the Marvell drivers also, highpoints
driver is (from what I can tell) a modified Marvell driver with their
binary software raid support added on, so the Marvell driver *may* also
have an issue with the later kernels.

                            Roger


