Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbTANIbN>; Tue, 14 Jan 2003 03:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbTANIbN>; Tue, 14 Jan 2003 03:31:13 -0500
Received: from mail.mediaways.net ([193.189.224.113]:42751 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S261518AbTANIbM>; Tue, 14 Jan 2003 03:31:12 -0500
Subject: Re: system freezes when using udma on promise pdc20268
From: Soeren Sonnenburg <bugreports@nn7.de>
To: Samuel Flory <sflory@rackable.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3E236A0F.2080605@rackable.com>
References: <1042492068.1199.11.camel@sun>  <3E236A0F.2080605@rackable.com>
Content-Type: text/plain
Organization: 
Message-Id: <1042532997.1209.3.camel@sun>
Mime-Version: 1.0
Date: 14 Jan 2003 09:29:58 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-14 at 02:38, Samuel Flory wrote:

> >The setup is asus a7v8x with sound/ide/firewire onboard. Two 180GB WDC
> >WD1800JB-00DUA0 on the primary and secondary internal VIA controller and
> >3 drives on two pdc20268, where the third hard disk is on the secondary
> >controller (I explain later why!). All harddisk are jumpered to be
> >master's.
> >  
> >
>   Are you stating this correctly.   You've got 2 drives on the PDC20268 
> on a single ide chain jumpered as masters?  You should have one jumpered 
> as a master and a as a slave.  A single ide chain can have only one master.

2 out of 8 possible drives on the two PDC20268. one drive is master on
the primary controller, the other master on the secondary.
another drive is secondary master on the second controller.

So unfortunately no two masters on the same ide chain.

Soeren.

