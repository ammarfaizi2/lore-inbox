Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267478AbUJOI5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267478AbUJOI5v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 04:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267415AbUJOI5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 04:57:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:43224 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S267186AbUJOI5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 04:57:47 -0400
From: Hans-Peter Jansen <hpj@urpla.net>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Ian Pilcher <i.pilcher@comcast.net>
Subject: Re: ATA/133 Problems with multiple cards
Date: Fri, 15 Oct 2004 10:57:01 +0200
User-Agent: KMail/1.5.4
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
References: <Pine.LNX.4.44.0410141710390.1681-100000@beast.stev.org> <ckmfiq$rc7$1@sea.gmane.org> <58cb370e04101412312fc42a57@mail.gmail.com>
In-Reply-To: <58cb370e04101412312fc42a57@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410151057.01713.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 October 2004 21:31, Bartlomiej Zolnierkiewicz wrote:
> On Thu, 14 Oct 2004 13:12:42 -0500, Ian Pilcher 
<i.pilcher@comcast.net> wrote:
> > James Stevenson wrote:
> > > i seem to have run into an annoying problem with a machine
> > > which has 3 promise ata/133 card the PDC20269 type.
> >
> > ....
> >
> > > Does anyone have an explenation of why this can happen ?
>
> * check power supply
> * compare PCI config space of the "failing" controller to the one
> which is "working" (assuming that identical devices are connected
> to each), maybe firmware/driver forgets to setup some settings
>
> > Promise cards don't support more than two per machine.  If you
> > can get a third card to work in PIO mode, consider it an added
> > (but unsupported) bonus.
>
> AFAIR people have been running 4-5 cards just fine

* apic mode is helpful
* current and even more important _identical_ firmware versions on all 
cards, which is quite annoying, since the promise DOS firmware loader 
doesn't like to be executed from a nbi ramdisk, neither on C:\ nor on 
A:\ and I hate booting DOS from floppy.. :-(

Pete

