Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261544AbSJNNFH>; Mon, 14 Oct 2002 09:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261552AbSJNNFH>; Mon, 14 Oct 2002 09:05:07 -0400
Received: from pc132.utati.net ([216.143.22.132]:34467 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S261544AbSJNNFF>; Mon, 14 Oct 2002 09:05:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: DervishD <raul@pleyades.net>, Andreas Steinmetz <ast@domdv.de>
Subject: Re: Known 'issues' about 2.4.19...
Date: Sun, 13 Oct 2002 20:15:46 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
References: <20021013184052.GC46@DervishD> <3DA9D0C7.60701@domdv.de> <20021013200209.GC106@DervishD>
In-Reply-To: <20021013200209.GC106@DervishD>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021014131202.1A4F4635@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 October 2002 04:02 pm, DervishD wrote:
>     Hi Andreas :)
>
> > >    Is there any known bug or other issues about 2.4.19 that prevents
> >
> > Bonding is broken.
>
>     Do you refer to NIC bonding? Anyway, I don't know what 'bonding'
> is, just I've heard the word related to NIC O:)))

It lets you use two ethernet cards as a single interface, assuming the switch 
they're plugged into supports it.  Cheap way to get 200 mbps throughput, 
especially with a switch that only does gigabit on the uplink port.

See Documentation/networking/bonding.txt in the kernel tarball...

Rob

