Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261605AbSKLPb7>; Tue, 12 Nov 2002 10:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSKLPb7>; Tue, 12 Nov 2002 10:31:59 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:37030 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261605AbSKLPb5>; Tue, 12 Nov 2002 10:31:57 -0500
Subject: Re: ATI Radeon IGP 320M Linux support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Cheney <ccheney@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021112151622.GC16414@cheney.cx>
References: <20021112151622.GC16414@cheney.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Nov 2002 16:03:49 +0000
Message-Id: <1037117029.8313.59.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-12 at 15:16, Chris Cheney wrote:
> 
> I recently purchased a Compaq Presario 900Z laptop and discovered it
> used a ATI Radeon IGP 320M chipset.
> 
> http://mirror.ati.com/technology/hardware/radeonigp/rigp320m.html
> 
> >From the pci output it looks like it uses ALi parts but at least with
> kernel 2.4.18 it will not boot properly (Yes, Windows XP runs on it).
> I tried to install Debian on it (2.4.18 kernel) and at first it hangs
> with a machine check exception unless nomce is passed, then it will
> give errors like this:

Nobody has managed to make Linux run on this laptop that I know of. As a
starting point you might want to build a kernel with no PCI IDE support,
and no USB support and work from there.

We have no documentation on the ATI IDE or other components in the
system.

Alan

