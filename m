Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTJQBrS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 21:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbTJQBrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 21:47:18 -0400
Received: from dslb138.fsr.net ([12.7.7.138]:12988 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S263271AbTJQBrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 21:47:16 -0400
Message-ID: <1066355235.3f8f4a2395fa0@horde.sandall.us>
Date: Thu, 16 Oct 2003 18:47:15 -0700
From: Eric Sandall <eric@sandall.us>
To: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws> <20031017013245.GA6053@ncsu.edu>
In-Reply-To: <20031017013245.GA6053@ncsu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 192.168.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting jlnance@unity.ncsu.edu:
> But at the same time we rely on TCP/IP which uses a hash (checksum)
> to detect back packets.  It seems to work well in practice even
> though the hash is weak and the network corrupts a lot of packets.
> 
> Lots of machines dont have ECC ram and seem to work reasonably well.
> 
> It seems like these two are a lot more likely to bit you than hash
> collisions in MD5.  But Ill have to go read the paper to see what
> Im missing.
> 
> Thanks,
> 
> Jim

It doesn't really matter that the hash collision is /less/ likely to ruin data
than something in hardware as it adds an /extra/ layer of possible corruption,
so you have a net gain in the possible corruption of your data.  Now, if you
could write it so that there was /no/ possibility of data corruption, than it
would be much more acceptable as it wouldn't add any extra likeliness of
corruption than already exists.

-sandalle

-- 
PGP Key Fingerprint:  FCFF 26A1 BE21 08F4 BB91  FAED 1D7B 7D74 A8EF DD61
http://search.keyserver.net:11371/pks/lookup?op=get&search=0xA8EFDD61

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS/E/IT$ d-- s++:+>: a-- C++(+++) BL++++VIS>$ P+(++) L+++ E-(---) W++ N+@ o?
K? w++++>-- O M-@ V-- PS+(+++) PE(-) Y++(+) PGP++(+) t+() 5++ X(+) R+(++)
tv(--)b++(+++) DI+@ D++(+++) G>+++ e>+++ h---(++) r++ y+
------END GEEK CODE BLOCK------

Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Inst. Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
