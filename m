Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSGHRWa>; Mon, 8 Jul 2002 13:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317026AbSGHRW3>; Mon, 8 Jul 2002 13:22:29 -0400
Received: from pD952ABA4.dip.t-dialin.net ([217.82.171.164]:18903 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317022AbSGHRW2>; Mon, 8 Jul 2002 13:22:28 -0400
Date: Mon, 8 Jul 2002 11:23:23 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Daniel Gryniewicz <dang@fprintf.net>
cc: Thunder from the hill <thunder@ngforever.de>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Daniel Phillips <phillips@arcor.de>, Pavel Machek <pavel@ucw.cz>,
       "Stephen C. Tweedie" <sct@redhat.com>, Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
In-Reply-To: <1026143302.4840.4.camel@athena.fprintf.net>
Message-ID: <Pine.LNX.4.44.0207081121280.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8 Jul 2002, Daniel Gryniewicz wrote:
> Okay, maybe this is a bit naive, but isn't this problem already solved? 
> Couldn't we just put a read/write lock on the module, where using is
> reading, and removing is writing?  As I understand it, this should
> impose little overhead on the use (read) case, and ensure that, when a
> context has the remove (write) lock there are no no users (readers) and
> cannot be any?

My suggestion could cope with just one lock, but there seems to be 
something speaking against that.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

