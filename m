Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316585AbSGQTd7>; Wed, 17 Jul 2002 15:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316586AbSGQTd7>; Wed, 17 Jul 2002 15:33:59 -0400
Received: from pD952AE51.dip.t-dialin.net ([217.82.174.81]:37276 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316585AbSGQTd6>; Wed, 17 Jul 2002 15:33:58 -0400
Date: Wed, 17 Jul 2002 13:35:22 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: bill davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit
In-Reply-To: <ah4cao$2ne$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0207171333010.3452-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17 Jul 2002, bill davidsen wrote:
> | int module_do_blah(struct blah *blah, didel_t dei)
> | #ifdef __MODULE__
> | {
> | 	locking_code();
> | 	pure_module_do_blah(blah, dei)
> | 	unlocking_code();
> | }
> | 
> | int pure_module_do_blah(struct blah *blah, didel_t dei)
> | #endif /* __MODULE__ */
> 
> I might write the un/lock code as a macro rather than use the ifdef, but
> that's a style thing.

Well, this was the "unpacked" version. Of course one could do that much 
better as a macro MODULE_CALL or whatever. However, Roman Zippel promised 
to come up with a better solution, and he did come up with a solution. I 
didn't yet look at it too much (I've had a trip around the world for 
administration purposes), but I don't exclude that it migh be a better 
one.

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

