Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317334AbSHOTSK>; Thu, 15 Aug 2002 15:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317345AbSHOTSK>; Thu, 15 Aug 2002 15:18:10 -0400
Received: from calhau.terra.com.br ([200.176.3.20]:55440 "EHLO
	calhau.terra.com.br") by vger.kernel.org with ESMTP
	id <S317334AbSHOTSJ>; Thu, 15 Aug 2002 15:18:09 -0400
Date: Thu, 15 Aug 2002 16:21:55 -0300
From: Christian Reis <kiko@async.com.br>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: eepro100@scyld.com, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: General network slowness on SIS 530 with eepro100
Message-ID: <20020815162155.L30462@blackjesus.async.com.br>
References: <20020813212923.L2219@blackjesus.async.com.br> <200208150844.g7F8iQp19827@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208150844.g7F8iQp19827@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Thu, Aug 15, 2002 at 11:41:20AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 11:41:20AM -0200, Denis Vlasenko wrote:
> On 13 August 2002 22:29, Christian Reis wrote:
> > On tri, which is the referred SIS530 box, as you can see, for most runs
> > the CPU usage is just so much higher than minas, which has practically
> > the same setup: K6-500, old PCI (no AGP) board, eepro100 card. I'm
> > wondering if anybody has seen something like this before?
> 
> Start swapping hardware between these two boxes

I've done it, actually. I've swapped processor, memory and video cards
(which are the only things the boxes actually contain) and there has
been no change. It's very strange - block read and block write consume
enormous amounts of CPU, no matter how much I tinker. I've tried 2.4.19,
2.2.21, NFS patches, etc. 

There could be a hidden BIOS option, but I can't seem to find out what
it is. Both caches are enabled. PCI interrupts are fine. It has to be a
motherboard support problem; in Windows the box runs fine. :-(

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
