Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129876AbRBZUPF>; Mon, 26 Feb 2001 15:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129986AbRBZUO7>; Mon, 26 Feb 2001 15:14:59 -0500
Received: from assembly.state.ny.us ([204.97.104.2]:54682 "EHLO
	assembly.state.ny.us") by vger.kernel.org with ESMTP
	id <S129876AbRBZUOl>; Mon, 26 Feb 2001 15:14:41 -0500
Date: Mon, 26 Feb 2001 15:14:24 -0500
From: jerry <jdinardo@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: USB and 2.4.2: "uhci: host system error, PCI problems?"
Message-ID: <20010226151424.A857@ix.netcom.com>
In-Reply-To: <20010223144004.A30274@convergence.de> <E14XPcd-00085C-00@aleph0.datakart.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14XPcd-00085C-00@aleph0.datakart.hu>; from fero@drama.obuda.kando.hu on Mon, Feb 26, 2001 at 04:31:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do not think the problem has anything to do with rivafb. I get the same
problem with 2.4.2 when i have dma enabled on my ide disk on my ABIT kt7
which is a via base Athlon mobo as well.

If you have dma enabled , try disabling it and see if the problem goes away
, although now you have a new problem ( slow disk).

jpd
> > Any ideas?  It's a VIA based Athlon board.  Worked fine with 2.4.0 and
> > 2.4.1.  The only change was that I added rivafb, which finally adds
> > Geforce support in 2.4.2.  /proc/interrupts does not show any interrupts
> > assigned to rivafb, maybe there is a conflict?
