Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318013AbSGRMIv>; Thu, 18 Jul 2002 08:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318024AbSGRMIu>; Thu, 18 Jul 2002 08:08:50 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:9912 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318013AbSGRMIu>; Thu, 18 Jul 2002 08:08:50 -0400
Date: Thu, 18 Jul 2002 14:06:04 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andre Hedrick <andre@linux-ide.org>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19rc2 and Promise RAID controller
Message-ID: <20020718120604.GA814@df1tlpc.local.here>
References: <Pine.SOL.4.30.0207180223130.12077-100000@mion.elka.pw.edu.pl> <Pine.SOL.4.30.0207180237300.12077-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0207180237300.12077-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 02:39:47AM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> On Thu, 18 Jul 2002, Bartlomiej Zolnierkiewicz wrote:
> 
> > Stupid me :-)
> > Setting it on/off won't help :-)
> 
> Stupid^2, please set it on and change this #ifdef.
> 
> > Just change '#ifdef' around
> > 	if (dev->class >> 8 == PCI_CLASS_STORAGE_RAID)
> > in ide-pci.c to '#ifndef' and it should work.
> 
> Regards
> --
> Bartlomiej

With CONFIG_PDC202XX_FORCE set to on and the change of the 
#ifdef to #ifndef the "Promise RAID controller" is now detected
in 2.4.19.rc2 and works as before.

-- 
Regards Klaus

