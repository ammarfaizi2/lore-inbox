Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317830AbSGKMvu>; Thu, 11 Jul 2002 08:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317832AbSGKMvt>; Thu, 11 Jul 2002 08:51:49 -0400
Received: from pD952AE71.dip.t-dialin.net ([217.82.174.113]:29576 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317830AbSGKMvs>; Thu, 11 Jul 2002 08:51:48 -0400
Date: Thu, 11 Jul 2002 06:54:25 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Hannu Savolainen <hannu@opensound.com>
cc: george anzinger <george@mvista.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
In-Reply-To: <Pine.LNX.4.10.10207110847170.6183-100000@zeus.compusonic.fi>
Message-ID: <Pine.LNX.4.44.0207110651430.5067-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Jul 2002, Hannu Savolainen wrote:
> This is not a problem at all. Just define HZ as:
> 
> extern int system_hz;
> #define HZ system_hz
> 
> After that all code will use variable HZ. Changing HZ on fly will be
> dangerous. However HZ can be made a boot time (LILO) parameter.

OK, that's probably a start. As the next step, I'd recommend that the 
maintainers and their supporters try to replace the static HZ with 
possibly-dynamic system_hz. The third step would be to have guys like Ingo 
to tune system_hz to be really dynamic.

Cool idea, anyway.

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

