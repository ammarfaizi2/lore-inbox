Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTGGIfN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 04:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTGGIfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 04:35:13 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:3255 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263632AbTGGIfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 04:35:08 -0400
Date: Mon, 7 Jul 2003 10:49:36 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Ryan Mack <lists@mackman.net>,
       Markus Plail <linux-kernel@gitteundmarkus.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 ServerWorks DMA Bugs
Message-ID: <20030707084936.GF303@louise.pinerecords.com>
References: <20030706184242.A20851@ucw.cz> <Pine.LNX.4.10.10307061740150.29935-100000@master.linux-ide.org> <20030707034217.GD303@louise.pinerecords.com> <1057560151.2413.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057560151.2413.1.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [alan@lxorguk.ukuu.org.uk]
> 
> On Llu, 2003-07-07 at 04:42, Tomas Szepe wrote:
> > > Just the view from an insider in the know.
> > 
> > Hmm, I certainly wouldn't expect a $3500 server to come with busted
> > IDE, but thanks for the suggestion, we'll take extra care.
> 
> You might also want to check with HPaq about BIOS updates. I have
> seen a couple of boxes which didnt set DMA but meant to or did
> after BIOS update.

Too late now, the machine is collecting IP accounting statistics
for 20 C's, 24/7.  Flashing the BIOS seems too risky given we're
only using the IDE drives for nightly backups of a SCSI raid1 root
fs.  I guess I'll just write a simple script to see if the backup
data tends to get hosed.

Thanks!
-- 
Tomas Szepe <szepe@pinerecords.com>
