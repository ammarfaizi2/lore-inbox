Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315387AbSEBUH7>; Thu, 2 May 2002 16:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSEBUH6>; Thu, 2 May 2002 16:07:58 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55311 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315387AbSEBUH6>; Thu, 2 May 2002 16:07:58 -0400
Subject: Re: IDE hotplug support?
To: jakob@unthought.net (=?iso-8859-1?Q?Jakob_=D8stergaard?=)
Date: Thu, 2 May 2002 21:26:38 +0100 (BST)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        pavel@suse.cz (Pavel Machek), roy@karlsbakk.net (Roy Sigurd Karlsbakk),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020502215833.V31556@unthought.net> from "=?iso-8859-1?Q?Jakob_=D8stergaard?=" at May 02, 2002 09:58:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173N9y-0004k1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >=20
> > 8 x 130MBy/s >>>> PCI bus throughput... I would rather recommend
> > a classical RAID controller card for this kind of
> > setup.
> 
> Because RAID controllers do not use the PCI bus ???    ;)

The raid card transfers the data once, software raid once per device for
Raid 1/5 - thats a killer.

> By the way, has anyone tried such larger multi-controller setups, and t=
> ested
> the bandwidth in configurations with multiple PCI busses on the board, =
> versus a
> single PCI bus ?

With 2.4 yes. With all the 2.5 changes no.
