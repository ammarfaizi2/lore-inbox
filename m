Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSGGTjl>; Sun, 7 Jul 2002 15:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSGGTjk>; Sun, 7 Jul 2002 15:39:40 -0400
Received: from pD952A04C.dip.t-dialin.net ([217.82.160.76]:26575 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316519AbSGGTjj>; Sun, 7 Jul 2002 15:39:39 -0400
Date: Sun, 7 Jul 2002 13:41:35 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       M?ns Rullg?rd <mru@users.sourceforge.net>,
       Mohamed Ghouse Gurgaon <MohamedG@ggn.hcltech.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Diff b/w 32bit & 64-bit
In-Reply-To: <20020707191232.A11999@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0207071338570.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 7 Jul 2002, Jamie Lokier wrote:
> > don't cast from "foo *" to "bar *" if sizeof(foo)<sizeof(bar)
> 
> What is the reason for this?  I do it quite routinely ("poor man's
> inheritance").

This should only be OK if you pad bar before.

The reason is this one:
foo:
[00111001000011111101001010010101]
(bar *)foo
[00111001000011111101001010010101xunpredictablex]

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


