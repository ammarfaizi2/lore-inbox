Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261450AbSKFJ3c>; Wed, 6 Nov 2002 04:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262152AbSKFJ3c>; Wed, 6 Nov 2002 04:29:32 -0500
Received: from hvs.envisage.co.za ([196.36.161.89]:3475 "EHLO
	hvs.envisage.co.za") by vger.kernel.org with ESMTP
	id <S261450AbSKFJ3b>; Wed, 6 Nov 2002 04:29:31 -0500
Date: Wed, 6 Nov 2002 11:34:49 +0200
From: Hendrik Visage <hvisage@envisage.co.za>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mike Diehl <mdiehl@dominion.dyndns.org>, Kevin Corry <corryk@us.ibm.com>,
       evms-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Evms-devel] Re: [Evms-announce] EVMS announcement
Message-ID: <20021106093449.GE465@hvs.envisage.co.za>
References: <02110516191004.07074@boiler> <20021105214012.C2B4651CF@dominion.dyndns.org> <20021105215100.E927E51CF@dominion.dyndns.org> <1036542080.7386.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036542080.7386.24.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook is Exploitable! -- http://www.rodos.net/outlook/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 12:21:20AM +0000, Alan Cox wrote:
> On Tue, 2002-11-05 at 21:11, Mike Diehl wrote:
> > The biggest thing that EVMS had going for it was it's modular design.  As I 
> > understand it, EVMS could even be used to manage the current MD and LVM 
> > drivers.  I was looking forward to partition-level encryption, etc.  
> 
> Thats a seperate issue in the pile. You might want to do things like
> 
> 			lvm2 volumes

Quick question Alan: Are you saying that EVMS can't do this ??

Hendrik

>                              |
>                            RAID-5
>                        /  |  \   \
>                     4 encrypted volumes with different keys
>                        |      |         |        |
>                              4 NBD disk volumes over TCP
> 			    (or 4 iSCSI volumes)
> 
>                      4 physical disks in different jurisdictions
> 
> 
> (and the physical disks or iscsi volumes might in fact be over lvm2 on
> the othe end - its all a lot more modular than just volume management at
> least at the kernel level - tools is different)
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: See the NEW Palm 
> Tungsten T handheld. Power & Color in a compact size!
> http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
> _______________________________________________
> Evms-devel mailing list
> Evms-devel@lists.sourceforge.net
> To subscribe/unsubscribe, please visit:
> https://lists.sourceforge.net/lists/listinfo/evms-devel
