Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262922AbRFMKaw>; Wed, 13 Jun 2001 06:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263139AbRFMKam>; Wed, 13 Jun 2001 06:30:42 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:50885 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S262922AbRFMKad>; Wed, 13 Jun 2001 06:30:33 -0400
Date: Wed, 13 Jun 2001 11:30:24 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@yellow.csi.cam.ac.uk>
To: Pavel Machek <pavel@suse.cz>
cc: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3com Driver and the 3XP Processor
In-Reply-To: <20010612161237.C33@toy.ucw.cz>
Message-ID: <Pine.SOL.4.33.0106131128360.13864-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2001, Pavel Machek wrote:

> Hi!
>
> > I just had one of the "3com Etherlink 10/100 PCI NIC with 3XP processor"
> > float accross my desk, I was wondering how much the linux kernel uses the
> > 3xp processor for its encryption offloading and such.  According to the
> > hype it does DES without using the CPU, does linux take advantage of that?
>
> Doing DES is uninteresting these days...
>
> That feature is useless --- everything but IPsec does encryption at
> application layer where NIC can not help.

Now, if the NIC were to integrate with OpenSSL and offload some of THAT
donkey work... Just offloading DES isn't terribly useful, as Pavel says:
apart from anything else, DES is a bit elderly now - SSH using 3DES or
Blowfish etc... How dedicated is this card? Could it be used to offload
other work?


James.

