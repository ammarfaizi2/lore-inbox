Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132392AbRDPWsW>; Mon, 16 Apr 2001 18:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132396AbRDPWsC>; Mon, 16 Apr 2001 18:48:02 -0400
Received: from quechua.inka.de ([212.227.14.2]:30833 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S132392AbRDPWr5>;
	Mon, 16 Apr 2001 18:47:57 -0400
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ARP responses broken!
In-Reply-To: <Pine.LNX.4.33.0104162335170.30406-100000@nalle.netsonic.fi>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.36 (i686))
Message-Id: <E14pHmk-0000u1-00@sites.inka.de>
Date: Tue, 17 Apr 2001 00:47:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0104162335170.30406-100000@nalle.netsonic.fi> you wrote:
> The second one is the valid one, but both interfaces seem to answer to the
> broadcasted packet with their own ARP addresses.

it is because the kernel does not know if both interfaces are on one subnet,
or not. The easisets thing to solve this is t use the MAC moduleof netfilter
and deny the incoming requests/responsnes based on the ip.

Greetings
Bernd
