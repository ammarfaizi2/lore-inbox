Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUJIAuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUJIAuk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 20:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266352AbUJIAuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 20:50:40 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:57914 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266349AbUJIAuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 20:50:39 -0400
Message-ID: <58cb370e04100817508fe62d0@mail.gmail.com>
Date: Sat, 9 Oct 2004 02:50:38 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Subject: Re: Problem with ide=nodma
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0410090140020.26639@ppg_penguin.kenmoffat.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0410090019150.26458@ppg_penguin.kenmoffat.uklinux.net>
	 <58cb370e04100817353254b8cd@mail.gmail.com>
	 <Pine.LNX.4.58.0410090140020.26639@ppg_penguin.kenmoffat.uklinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Oct 2004 01:44:57 +0100 (BST), Ken Moffat
<ken@kenmoffat.uklinux.net> wrote:
> On Sat, 9 Oct 2004, Bartlomiej Zolnierkiewicz wrote:
> 
> > On Sat, 9 Oct 2004 00:32:01 +0100 (BST), Ken Moffat
> > <ken@kenmoffat.uklinux.net> wrote:
> > > Hi,
> > >
> > >  I'm trying a sii 0680 disk controller at the moment, as a possible
> > > workaround for some via southbridge problems (this is on a ppc which
> > > isn't yet supported by the official kernels, but it has been stable here
> > > since 2.6.7 and looks nearly ready for a first review).  Unfortunately,
> > > DMA is a big no go at the moment so I have to pass ide=nodma in the
> > > bootargs.
> > >
> > >  I've got the drives plugged into the sii card, and ide=reverse is doing
> > > its job.  But although dmesg shows that dma has been turned off,
> >
> > Is it possible that you are reading it wrong?
> 
>  I don't think so, and the box is a lot more responsive.  dmesg shows
> 
> ide_setup: ide=nodmaIDE: Prevented DMA

This is misleading as drivers are free to override this setting.
