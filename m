Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265116AbUAJMPl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 07:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265128AbUAJMPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 07:15:41 -0500
Received: from intra.cyclades.com ([64.186.161.6]:11195 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265116AbUAJMPk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 07:15:40 -0500
Date: Sat, 10 Jan 2004 10:06:40 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: martin f krafft <madduck@madduck.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: stability problems with 2.4.24/Software RAID/ext3
In-Reply-To: <20040109185348.GA24499@piper.madduck.net>
Message-ID: <Pine.LNX.4.58L.0401101005470.3641@logos.cnet>
References: <20040108151225.GA11740@piper.madduck.net>
 <1073671862.24706.13.camel@tux.rsn.bth.se> <20040109185348.GA24499@piper.madduck.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jan 2004, martin f krafft wrote:

> also sprach Martin Josefsson <gandalf@wlug.westbo.se> [2004.01.09.1911 +0100]:
> > Try replacing the Promise controllers with something diffrent (doesn't
> > really matter what).
>
> Well, I can't find any other suitable ones, really. I can't seem to
> find HighPoints, there is 3ware and DawiControl, but I don't know
> which ones are supported by Linux.
>
> Maybe someone can give me a suggestion for a non-promise EIDE 133
> PCI controller that's natively supported by Linux.
>
> > I personally have a pdc20267 in my workstation that I stress quite
> > heavily sometimes and I've never had any problems with it.
>
> that's a different driver. so it might be the driver that's causing
> the problems. if i replace the controller, i may be able to debug,
> but unless i get a new controller in place, i can't do anything
> since this is a productive machine.

Did you ever try to disable the DMA as suggested?
