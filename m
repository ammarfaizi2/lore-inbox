Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWBOSbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWBOSbS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 13:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWBOSbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 13:31:17 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:5264 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750889AbWBOSbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 13:31:17 -0500
Date: Wed, 15 Feb 2006 13:31:15 -0500
To: Rob Landley <rob@landley.net>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060215183115.GE29940@csclub.uwaterloo.ca>
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com> <200602141751.02153.rob@landley.net> <20060215000420.GB21088@merlin.emma.line.org> <200602142155.03407.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602142155.03407.rob@landley.net>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 09:55:03PM -0500, Rob Landley wrote:
> The last gasp of the SCSI bigots is Serial Attached Scsi.  It's hilarious.  
> Electrically it's identical (they just gold-plate the connectors and such so 
> they can charge more for it).  The giveaway is that you can plug a SATA drive 
> into a SAS controller and it works on "dual standard" controller firmware.  
> Which one's going to have the unit volume to be cheap and sell through its 
> inventory to bring out new generations faster?  And which one is exactly the 
> same technology with buckets of hype, slightly different firmware, and a huge 
> markup for the people who still think that because ISA sucked, its designated 
> successor PCI can't be trusted?

SAS is actually a lot more complex than SATA.  SAS drives are dual
ported, so you can connect them to two controllers at once.  Makes
redundant systems much simpler to build if you can connect each physical
drive to two places at once.  They support port expanders (which SATA
seems to be starting to support although more limited).  You can run
SATA drives on an SAS controller, but of course you don't get dual port.
You can not run SAS drives on an SATA controller however.  SATA is
essentially a subset of SAS.

Len Sorensen
