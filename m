Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbVIYCyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbVIYCyL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 22:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbVIYCyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 22:54:11 -0400
Received: from web35508.mail.mud.yahoo.com ([66.163.179.132]:22675 "HELO
	web35508.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751062AbVIYCyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 22:54:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=thRpdMq1LMxKRFHgOL7afFiW9JdXgQETdOly9tNNhehqlb595XflOcPuT52OoSlBPu8CaaQ4OURpSZOn6BKqC3gGl7I5Gy2MEQ1o3QCk3ZMhn76e5aB0HUk9bRSKgfVTwnj+S6qqFgOlRZQ83qMaVb29jVWphhoTRZ85wzRyQZo=  ;
Message-ID: <20050925025409.6415.qmail@web35508.mail.mud.yahoo.com>
Date: Sat, 24 Sep 2005 19:54:09 -0700 (PDT)
From: Bob Henry <bobhenry99@yahoo.com>
Subject: Re: Supporting ACPI drive hotswap
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I saw the same thing.

-Bob



> --- Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> 
> > On Sat, Sep 24, 2005 at 03:45:45PM -0400, Mark
> Lord
> > wrote:
> > > >Do you know why the ahci driver won't load?
> > > 
> > > Undoubtedly the chip is being used in "combined
> > mode",
> > > to support a PATA ATAPI device on the second
> > channel.
> > > 
> > > For that matter, the primary HD is probably
> > actually PATA,
> > > perhaps with a SATA bridge on the notebook M/B.
> > > 
> > > Very very common arrangement these days --
> > practically all
> > > Sonoma Centrino chipset notebooks are set up
> like
> > this.
> > 
> > Yeah, I'd guess something along those lines. The
> CD
> > drive presents as 
> > SATA, but looks more like a PATA part.
> > pci_request_regions fails when 
> > trying to load ahci. It's a Sonoma system (Dell
> > Latitude D610)
> > 
> > Tyffani Purnell
> > tyffani@cableaz.com
> > Gregory Roman
> > gregroman4@earthlink.net
> > Joseph A Zyskowski
> > JosephAZyskowski@yahoo.com
> > Mike Hafen
> > mike@mikehafen.com
> > -- 
> > Matthew Garrett | mjg59@srcf.ucam.org
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 
> 
> 	
> 		
>
______________________________________________________
> 
> Yahoo! for Good 
> Donate to the Hurricane Katrina relief effort. 
> http://store.yahoo.com/redcross-donate3/ 
> 
> 



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
