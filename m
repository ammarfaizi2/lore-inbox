Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbRETJko>; Sun, 20 May 2001 05:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbRETJke>; Sun, 20 May 2001 05:40:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5424 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S261502AbRETJkY>; Sun, 20 May 2001 05:40:24 -0400
To: Jonathan Lundell <jlundell@pobox.com>
Cc: kaih@khms.westfalen.de (Kai Henningsen), linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <811opRpHw-B@khms.westfalen.de> <Pine.LNX.4.21.0105151107290.2112-100000@penguin.transmeta.com> <p05100316b7272cdfd50c@[207.213.214.37]> <811opRpHw-B@khms.westfalen.de> <p05100301b72a335d4b61@[10.128.7.49]> <81BywVLHw-B@khms.westfalen.de> <p0510031eb72c5f11b8c7@[207.213.214.37]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 May 2001 03:37:14 -0600
In-Reply-To: Jonathan Lundell's message of "Sat, 19 May 2001 10:36:14 -0700"
Message-ID: <m1wv7cgy45.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell <jlundell@pobox.com> writes:

> At 10:42 AM +0200 2001-05-19, Kai Henningsen wrote:
> >  > Jeff Garzik's ethtool
> >  > extension at least tells me the PCI bus/dev/fcn, though, and from
> >>  that I can write a userland mapping function to the physical
> >>  location.
> >
> >I don't see how PCI bus/dev/fcn lets you do that.
> 
> I know from system documentation, or can figure out once and for all 
> by experimentation, the correspondence between PCI bus/dev/fcn and 
> physical locations. Jeff's extension gives me the mapping between 
> eth# and PCI bus/dev/fcn, which is not otherwise available (outside 
> the kernel).

Just a second let me reenumerate your pci busses, and change all of the bus
numbers.  Not that this is a bad thought.  It is just you need to know
the tree of PCI busses/bridges up to the root on the machine in question.

Eric
