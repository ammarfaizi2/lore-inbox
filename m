Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313201AbSDJPXq>; Wed, 10 Apr 2002 11:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313206AbSDJPXp>; Wed, 10 Apr 2002 11:23:45 -0400
Received: from angband.namesys.com ([212.16.7.85]:61832 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S313201AbSDJPXp>; Wed, 10 Apr 2002 11:23:45 -0400
Date: Wed, 10 Apr 2002 19:23:39 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: Brent Cook <busterb@mail.utexas.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mouse interrupts: the death knell of a VP6
Message-ID: <20020410192339.A22777@namesys.com>
In-Reply-To: <20020206191108.A11277@suse.de> <20020410083504.Y60587-100000@ozma.union.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Apr 10, 2002 at 09:02:05AM -0500, Brent Cook wrote:

> I have an ABIT VP6 motherboard, using the VIA Apollo chipset and 2 700Mhz
> PIII's, but please don't hold that against me. The system is running
> 2.4.19-pre6. I believe that I either have a system that has trouble
> handling a sudden bursts of interrupts, or have found a fault in mouse
> handling.

Have you tried to change MPS mode to 1.1 from 1.4 (I see addres message timeouts
in your log)?

> I have already tried removing memory, adding memory, changing processors,
> video cards. The only thing that has remained constant is the VP6
> motherboard and the hard drive.

My VP6 died on me recently with some funny symptoms:
it hangs in X when I start netscape and move mouse, or if I do
bk clone on kernel tree, it dies with
kernel BUG at /usr/src/linux-2.4.18/include/asm/smplock.h:62!
BUG in various places pretty soon.
(this BUG is only appears if 2 CPUs are present in motherboard).
So if your troubles began only recently, you might want to try another
motherboard just to be sure.

Bye,
    Oleg
