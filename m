Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263238AbUB1B0e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 20:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbUB1B0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 20:26:34 -0500
Received: from codepoet.org ([166.70.99.138]:58016 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S263238AbUB1B0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 20:26:32 -0500
Date: Fri, 27 Feb 2004 18:26:31 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       John Bradford <john@grabjohn.com>, Erik van Engelen <Info@vanE.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Errors on 2th ide channel of promise ultra100 tx2
Message-ID: <20040228012630.GA3074@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	John Bradford <john@grabjohn.com>, Erik van Engelen <Info@vanE.nl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <403F2178.70806@vanE.nl> <200402272114.23108.bzolnier@elka.pw.edu.pl> <20040227224431.GB984@codepoet.org> <200402280220.22324.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402280220.22324.bzolnier@elka.pw.edu.pl>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Feb 28, 2004 at 02:20:22AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > Dunno if I qualify as sufficiently 'really smart' enough but the
> > last time I put in the considerable effort needed to re-sync the
> > 2.4 and 2.6 IDE layers, and merge in the useful -ac bits that
> > never made it into mainstream, nothing whatsoever came of my
> > efforts...
> 
> Did you actually split and send out your patches? :)

Yes....
http://www.ussg.iu.edu/hypermail/linux/kernel/0308.2/0175.html

> > My 2.4.x patches are in daily use by a large group of people
> > and they work fine, for what it is worth.  My IDE merging
> > patches are the following:
> >
> >     http://codepoet.org/kernel/
> >
> >     020_ide_layer_2.4.22-ac4.bz2
> 
> Needs splitting and most of this stuff needs new re-sync with 2.6. :-(

Yup.  After splitting and submitting to no effect it was
less effort to maintain the lot as one big patch...

> >     021_ide_geom_hpa_capacity64.bz2
> 
> Now I remember why this wasn't applied.
> It breaks braindamaged HDIO_GETGEO_BIG_RAW ioctl
> (because changes way drive->cyls is calculated).
> We workaround-ed it in 2.6 by removing this ioctl. :)
> I think we really should do the same for 2.4.

I did just that but it was rejected by Alan Cox...
http://www.ussg.iu.edu/hypermail/linux/kernel/0308.2/0193.html

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
