Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281017AbRKCTO5>; Sat, 3 Nov 2001 14:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281018AbRKCTOs>; Sat, 3 Nov 2001 14:14:48 -0500
Received: from mustard.heime.net ([194.234.65.222]:18130 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S281017AbRKCTOa>; Sat, 3 Nov 2001 14:14:30 -0500
Date: Sat, 3 Nov 2001 20:14:26 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Thomas Lussnig <tlussnig@bewegungsmelder.de>
cc: <linux-kernel@vger.kernel.org>, khttpd mailing list <khttpd-users@zgp.org>,
        Tux mailing list <tux-list@redhat.com>
Subject: Re: [khttpd-users] khttpd vs tux
In-Reply-To: <3BE44096.2070808@bewegungsmelder.de>
Message-ID: <Pine.LNX.4.30.0111032012410.9435-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> how much do you think you can get out of a server with several 1Gb
>> ethernet cards, multiple 66MHz/64bit PCI busses, multiple SCSI busses or
>> perhaps some sort of SAN solution based on FibreChannel 2?
>
> Ok,
> on this hardware i think that the problem is the that the Kernel and
> Webserver need to suport that ( each of the 1Gbit card is bound to its
> own process and on Multiprozessor machine that the prozess is fixed to
> one CPU to minimize the siwtch overhead, also im not firm with the
> FibreChannel2
> spezifikation i think that there can some trouble with the load, but much
> more important is to know how much different data is served, because then
> you talk about khttpd i think that it is definit static data and so the
> question
> is how much, because on an ideal case the whole set of files is cached
> in the
> ram, with 500 hundred Users i think there is only minmal patch in the
> kernel to
> do for higher file handles. So if there is only there the choice left open
> tux or khttpd i think you should use tux

What's this patch thing?
Do I need to patch up or rewrite parts of the kernel to support <1000 file
handles?

---
Computers are like air conditioners.
They stop working when you open Windows.

