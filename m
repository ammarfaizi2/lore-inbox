Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWINJlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWINJlf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 05:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWINJle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 05:41:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:14868 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751512AbWINJle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 05:41:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FDAIGyAOKXL4pRQMuH39mkRcwZDSKW7t+yNd6XpwqxrdXHRL3u31mZBbtPMVbm3qiRwCYNkrKi0NIGeE2Y2Sf3YVtKgEvI6N8ThT/ZLayoymk7nQF+C/uoJNwSkRyjI6GgOrMyhOQ3hbTzpt1h4ecfj4wtA4Yr4o0ORBsMqQbP4=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Krzysztof Halasa <khc@pm.waw.pl>,
       Thomas Richter <thor@mail.math.tu-berlin.de>
Subject: Re: MSI K9N Neo: crash under heavy IDE read
Date: Thu, 14 Sep 2006 11:38:14 +0200
User-Agent: KMail/1.8.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, Dmytro_Puhach@cz.ibm.com
References: <200609121046.24610.vda.linux@googlemail.com> <m3irjr1r57.fsf@defiant.localdomain>
In-Reply-To: <m3irjr1r57.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609141138.14885.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for everyone answered.

The problem is resolved - one DDR2 module is bad now.

One month ago it survived overnight memtest run,
but now it is definitely bad. memtest detects problems
in a few seconds.

On Wednesday 13 September 2006 21:51, Krzysztof Halasa wrote:
> > Copying movies from SATA drive to PATA drive oopses
> > after few gigabytes transferred. Creating iso image
> > with mkisofs (done entirely on PATA drive, no SATA attached)
> > does the same.
> 
> I don't know about K9N Neo, but I have MSI K9N Ultra-2F (the same
> MCP55) and have no such issues. But:
> - I'm not using drivers/ide anymore (I was using 2.6.17.11 with
>   Alan's libata-PATA patch and now I have ca. 2.6.18-rc6 merged
>   with Jeff's pata-drivers git branch)
> - I have only PATA CD-ROM (and SATA disk, Seagate ST3250823AS).
> - just 1 GB of RAM.
> 
> Copied CD/DVD-ROM discs to HDD few times, no problems.

On Thursday 14 September 2006 10:33, Thomas Richter wrote:
> Not really, but allow me to make another comment: MSI seems to have
> massive problems with the K9N based boards. A good percentage of them
> just "freaks out" from time to time and shuts the system down with no
> aparent reason.

I found info about such mobos and preliminary analysis said
to indicate that one of mobo capacitors had wrong specs.
MSI said to start replacing affected mobos.

My mobo serial number doesn't seem to fall into range of
affected ones, but entire affair doesn't sound encouraging at all.

Not to mention that BIOS is somewhat more buggy that I expected, too.
--
vda
