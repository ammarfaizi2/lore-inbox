Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130020AbRCAWYB>; Thu, 1 Mar 2001 17:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129991AbRCAWXv>; Thu, 1 Mar 2001 17:23:51 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17424 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130053AbRCAWXk>; Thu, 1 Mar 2001 17:23:40 -0500
Subject: Re: The IO problem on multiple PCI busses
To: davem@redhat.com (David S. Miller)
Date: Thu, 1 Mar 2001 22:26:14 +0000 (GMT)
Cc: benh@kernel.crashing.org (Benjamin Herrenschmidt),
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <15006.44863.375642.847562@pizda.ninka.net> from "David S. Miller" at Mar 01, 2001 12:21:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14YbWc-0000Fx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is no 'fake' ISA bus number you need.  There is a 'real' one,
> the one on which the PCI-->ISA bridge lives, why not use that one
> :-)

IFF the ISA bus hangs off the PCI bridge. Similarly not all machines have
PCI as the primary I/O bus. On hppa PCI busses hang off the gsc bus

