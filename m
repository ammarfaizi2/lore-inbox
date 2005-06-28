Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVF1L7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVF1L7y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 07:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVF1L7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 07:59:54 -0400
Received: from mail1.kontent.de ([81.88.34.36]:27356 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261320AbVF1L7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 07:59:52 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Date: Tue, 28 Jun 2005 14:00:08 +0200
User-Agent: KMail/1.8
Cc: Mike Bell <kernel@mikebell.org>, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org
References: <20050624081808.GA26174@kroah.com> <20050627232559.GA7690@mikebell.org> <20050628074015.GA3577@kroah.com>
In-Reply-To: <20050628074015.GA3577@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506281400.08777.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 28. Juni 2005 09:40 schrieb Greg KH:
> On Mon, Jun 27, 2005 at 04:26:00PM -0700, Mike Bell wrote:
> > On Mon, Jun 27, 2005 at 05:35:50PM -0500, Dmitry Torokhov wrote:
> > > AFAIK there is no requirement in input subsystem that devices should be
> > > created under /dev/input. When devfs is activated they are created there
> > > by default, but that's it.
> > 
> > Things which accept a path to an event file as an argument will work
> > just fine. But anything which tries autodiscovery HAS to be able to find
> > the device nodes. Think directfb, most (but not all) of the X patches,
> > any user-space driver that wants to find the hardware it owns, etc.
> > 
> > This illustrates nicely my reasons for preferring devfs.
> > 
> > 1) Predictable, canonical device names are a Good Thing.
> 
> And impossible for the kernel to generate given hotpluggable devices.

That is not true. The kernel can generate predictable device names.
It just cannot generate _stable_ device names under all circumstances.

	Regards
		Oliver
