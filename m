Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265012AbTAJOWy>; Fri, 10 Jan 2003 09:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTAJOWy>; Fri, 10 Jan 2003 09:22:54 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26002
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265012AbTAJOWx>; Fri, 10 Jan 2003 09:22:53 -0500
Subject: Re: Linux 2.4.21pre3-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030110141729.GA31123@charite.de>
References: <200301090139.h091d9G26412@devserv.devel.redhat.com>
	 <20030110094504.GM25979@charite.de>
	 <1042200029.28469.55.camel@irongate.swansea.linux.org.uk>
	 <20030110111547.GB18007@charite.de> <20030110133028.GB12071@charite.de>
	 <20030110141729.GA31123@charite.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042211870.31612.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 15:17:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 14:17, Ralf Hildebrandt wrote:
> * Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:
> 
> > Backing out of mm/shmem.c makess thee bug disappear.
> 
> Not really. I rebooted and then the ac2 crashed DURING a fsck that was
> caused by reaching the maximum mount count.
> I'm outta here and back to 2.4.21pre3 :)

Curious indeed. I guess we'll find the problem when I submit the
troublesome change to Marcelo 8). I'll look at that keyboard
fix, that seems a fairly sane workaround. Next stop is zapping
the other bits of journal related stuff and checking network
card fixup corner cases - what ethernet do you have btw ?


Alan

