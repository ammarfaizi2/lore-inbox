Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291102AbSBXUaO>; Sun, 24 Feb 2002 15:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291103AbSBXUaD>; Sun, 24 Feb 2002 15:30:03 -0500
Received: from altus.drgw.net ([209.234.73.40]:30213 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S291102AbSBXU3x>;
	Sun, 24 Feb 2002 15:29:53 -0500
Date: Sun, 24 Feb 2002 14:29:03 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224142902.C1682@altus.drgw.net>
In-Reply-To: <Pine.LNX.4.10.10202232136560.5715-100000@master.linux-ide.org> <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com> <20020224013038.G10251@altus.drgw.net> <3C78DA19.4020401@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C78DA19.4020401@evision-ventures.com>; from dalecki@evision-ventures.com on Sun, Feb 24, 2002 at 01:18:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 01:18:33PM +0100, Martin Dalecki wrote:
> > Ummm, how does this work if I have two PCI ide cards, one on a 66mhz PCI 
> > bus, and one on a 33mhz PCI bus?
> > 
> > Or am I missing something?
> 
> You are missing the fact that it didn't work before.

What hardware, chipsets, situations, etc did the previous code not work
on?

There is no avoiding the fact you need some kind of per-IDE controller
data for the clock for that particular PCI device.

I believe there are systems with 33mhz pci and 50mhz pci. Trying to find a
'common' base clock just seems to be an excercise in confusion. The only
thing that really makes sense is 'how fast is said PCI device clocked'.

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
