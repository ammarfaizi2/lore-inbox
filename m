Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319378AbSIFUdT>; Fri, 6 Sep 2002 16:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319380AbSIFUdT>; Fri, 6 Sep 2002 16:33:19 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:48514 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319378AbSIFUdS>; Fri, 6 Sep 2002 16:33:18 -0400
Date: Fri, 6 Sep 2002 17:37:45 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Woller, Thomas" <tom.woller@cirrus.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: cs4281 & select in 2.4
In-Reply-To: <973C11FE0E3ED41183B200508BC7774C05233F8A@csexchange.crystal.cirrus.com>
Message-ID: <Pine.LNX.4.44L.0209061735200.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2002, Woller, Thomas wrote:

> Toshiba refused to lend us any laptops after repeated requests,
> so all the toshiba work has been without a unit to test with.
> There is at least one (that i remember) specific fix for toshiba
> systems in the driver.
> also does recording work at all?

Works fine with kpsk and other programs that just read.
It seems to break only with select()

> so, look at cs4281_setup_record_src(), and maybe commenting out
> the toshiba specific code concerning the recording sources might
> make a difference. or if the unit is NOT recognized, then forcing
> the code to setup as your unit as a 1640CDT and see if that
> helps.

I'll switch the debugging on and I'll see if anything
happens.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

