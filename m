Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291471AbSBXWFL>; Sun, 24 Feb 2002 17:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291475AbSBXWFB>; Sun, 24 Feb 2002 17:05:01 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:23814 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S291471AbSBXWEw>;
	Sun, 24 Feb 2002 17:04:52 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15481.25250.869765.860828@argo.ozlabs.ibm.com>
Date: Mon, 25 Feb 2002 09:01:06 +1100 (EST)
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Troy Benjegerdes <hozer@drgw.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <20020224215422.B1706@ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10202232136560.5715-100000@master.linux-ide.org>
	<Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com>
	<20020224013038.G10251@altus.drgw.net>
	<3C78DA19.4020401@evision-ventures.com>
	<20020224142902.C1682@altus.drgw.net>
	<20020224215422.B1706@ucw.cz>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik writes:

> On Sun, Feb 24, 2002 at 02:29:03PM -0600, Troy Benjegerdes wrote:
> > I believe there are systems with 33mhz pci and 50mhz pci. Trying to find a
> > 'common' base clock just seems to be an excercise in confusion. The only
> > thing that really makes sense is 'how fast is said PCI device clocked'.
> 
> Show me one.

We have some RS/6000 machines that have two separate PCI buses (two
host bridges) that run at 33MHz and 50MHz respectively.  Fortunately
we also get a device tree from the firmware that tells us this.

Paul.
