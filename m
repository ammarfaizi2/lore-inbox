Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbTCTNfd>; Thu, 20 Mar 2003 08:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261452AbTCTNfd>; Thu, 20 Mar 2003 08:35:33 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40076
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261449AbTCTNfd>; Thu, 20 Mar 2003 08:35:33 -0500
Subject: Re: Hardlocks with 2.4.21-pre5, pdc202xx_new (PDC20269) and shared
	IRQs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wolfram Schlich <wolfram@schlich.org>
Cc: Linux-Kernel mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20030320072259.ALLYOURBASEAREBELONGTOUS.E6336@bla.fasel.org>
References: <20030319221608.ALLYOURBASEAREBELONGTOUS.A29767@bla.fasel.org>
	 <1048124539.647.18.camel@irongate.swansea.linux.org.uk>
	 <20030320072259.ALLYOURBASEAREBELONGTOUS.E6336@bla.fasel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048172263.2408.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 Mar 2003 14:57:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-20 at 07:22, Wolfram Schlich wrote:
> Well, now I have trashed my array :-)
> -> http://marc.theaimsgroup.com/?l=linux-raid&m=104811878405765&w=2
> 
> Btw., it spits out *lots* of messages when IRQ sharing is *disabled*
> in the kernel config and just dies quietly when it's *enabled*
> (having it dying before didn't mess up my array... ;)).

I'll take a look. I have no promise docs however so there is little that
can be done for promise specific bugs if it looks that way.

> ?! I'm using the onboard IDE for two CDROM drives and one smaller
> hard disk which I use rarely... and I didn't use any of these devices
> in the cases in which I had the described problems... Anyway, why should I
> connect a PS/2 mouse to the machine? Is it gonna solve all my
> problems at once? ;-)

Probably not, but it will avoid a lockup with IDE DMA in a specific case

