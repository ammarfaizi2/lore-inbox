Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291247AbSBXUy5>; Sun, 24 Feb 2002 15:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291251AbSBXUyr>; Sun, 24 Feb 2002 15:54:47 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:34308 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291246AbSBXUyc>; Sun, 24 Feb 2002 15:54:32 -0500
Date: Sun, 24 Feb 2002 21:54:22 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224215422.B1706@ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10202232136560.5715-100000@master.linux-ide.org> <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com> <20020224013038.G10251@altus.drgw.net> <3C78DA19.4020401@evision-ventures.com> <20020224142902.C1682@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020224142902.C1682@altus.drgw.net>; from hozer@drgw.net on Sun, Feb 24, 2002 at 02:29:03PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 02:29:03PM -0600, Troy Benjegerdes wrote:

> On Sun, Feb 24, 2002 at 01:18:33PM +0100, Martin Dalecki wrote:
> > > Ummm, how does this work if I have two PCI ide cards, one on a 66mhz PCI 
> > > bus, and one on a 33mhz PCI bus?
> > > 
> > > Or am I missing something?
> > 
> > You are missing the fact that it didn't work before.
> 
> What hardware, chipsets, situations, etc did the previous code not work
> on?
>
> There is no avoiding the fact you need some kind of per-IDE controller
> data for the clock for that particular PCI device.

No. You don't need it. The base clock and multiplier are enough and you
have the multiplier from PCI config.

> I believe there are systems with 33mhz pci and 50mhz pci. Trying to find a
> 'common' base clock just seems to be an excercise in confusion. The only
> thing that really makes sense is 'how fast is said PCI device clocked'.

Show me one.

-- 
Vojtech Pavlik
SuSE Labs
