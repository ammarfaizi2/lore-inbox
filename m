Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318765AbSIFQJR>; Fri, 6 Sep 2002 12:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318764AbSIFQJR>; Fri, 6 Sep 2002 12:09:17 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:21976 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318765AbSIFQJQ>; Fri, 6 Sep 2002 12:09:16 -0400
Date: Fri, 6 Sep 2002 13:13:46 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Woller, Thomas" <tom.woller@cirrus.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: cs4281 & select in 2.4
In-Reply-To: <Pine.LNX.4.44L.0209061305170.1857-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44L.0209061311140.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2002, Rik van Riel wrote:
> On Fri, 6 Sep 2002, Woller, Thomas wrote:
>
> > which 2.4 version are you using? 2.4.19?  There was a ham-radio
> > select(2) fix in the cs4281 driver back in 2.4.17 era, think that

> > i'll put cs4281-src-20011214-01n-tar.bz2 into \cs4281 directory.
>
> Thanks.  I've just grabbed the tarball and will let you know
> if this fixes things.

You're right, all updates were already included in the 2.4.19
kernel. The only thing extra in your tarball is the 2.2 compat
code and two copy_to_user() return code fixes in cs4281_ioctl().

I wonder if it's some strange bug with the CS4281 hardware in
this Toshiba laptop:

00:08.0 Multimedia audio controller: Cirrus Logic Crystal CS4281 PCI Audio (rev 01)
        Subsystem: Toshiba America Info Systems: Unknown device ff00
        Flags: bus master, medium devsel, latency 64, IRQ 5
        Memory at fc010000 (32-bit, non-prefetchable) [size=4K]
        Memory at fc000000 (32-bit, non-prefetchable) [size=64K]

Does this ring a bell (pun intended) ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

