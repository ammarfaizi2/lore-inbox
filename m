Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbTCYD6p>; Mon, 24 Mar 2003 22:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261436AbTCYD6p>; Mon, 24 Mar 2003 22:58:45 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:7698 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261432AbTCYD6o>; Mon, 24 Mar 2003 22:58:44 -0500
Date: Mon, 24 Mar 2003 20:07:08 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@redhat.com>
cc: Vitezslav Samel <samel@mail.cz>, linux-kernel@vger.kernel.org
Subject: Re: [IDE SiI680] throughput drop to 1/4
In-Reply-To: <200303241754.h2OHsii27044@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.10.10303242003150.8000-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Mar 2003, Alan Cox wrote:

> > There should be a mode or a flag option in the siimage.h to disable MMIO
> > by default.  I am courious if this is a BARRIER on the read/write screwing
> > the pooch!
> 
> It cannot be involved. If you read the code you'll see the SII driver doesnt
> yet override outbsync so it can't be involved. We aren't doing any posting
> prevention yet
> 

Alan,

Humor me and isolate my silly concerns okay.
Prove me wrong and I will be happy.

It should be a single #undef in siimage.h

Cheers,

Andre Hedrick
LAD Storage Consulting Group

