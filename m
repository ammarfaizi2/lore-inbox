Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291633AbSBXW1Z>; Sun, 24 Feb 2002 17:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291664AbSBXW1Q>; Sun, 24 Feb 2002 17:27:16 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:52487 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S291637AbSBXW04>;
	Sun, 24 Feb 2002 17:26:56 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15481.26697.420856.1109@argo.ozlabs.ibm.com>
Date: Mon, 25 Feb 2002 09:25:13 +1100 (EST)
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Troy Benjegerdes <hozer@drgw.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <20020224231002.B2199@ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10202232136560.5715-100000@master.linux-ide.org>
	<Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com>
	<20020224013038.G10251@altus.drgw.net>
	<3C78DA19.4020401@evision-ventures.com>
	<20020224142902.C1682@altus.drgw.net>
	<20020224215422.B1706@ucw.cz>
	<15481.25250.869765.860828@argo.ozlabs.ibm.com>
	<20020224231002.B2199@ucw.cz>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik writes:
> On Mon, Feb 25, 2002 at 09:01:06AM +1100, Paul Mackerras wrote:
> > We have some RS/6000 machines that have two separate PCI buses (two
> > host bridges) that run at 33MHz and 50MHz respectively.  Fortunately
> > we also get a device tree from the firmware that tells us this.
> 
> I really wonder why the 50 MHz one doesn't run at 66 MHz, and what

Apparently the rationale is that you can put more slots on the bus
if you run it at 50MHz than you can at 66MHz.

> happens if you plug in a 66MHz non-capable card to the 50 MHz bus.

The bus speed drops to 33MHz.

Paul.
