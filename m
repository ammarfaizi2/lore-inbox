Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282204AbRK2AHD>; Wed, 28 Nov 2001 19:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282205AbRK2AGx>; Wed, 28 Nov 2001 19:06:53 -0500
Received: from ja.mac.ssi.bg ([212.95.166.194]:3589 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S282204AbRK2AGo>;
	Wed, 28 Nov 2001 19:06:44 -0500
Date: Thu, 29 Nov 2001 02:07:18 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@u.domain.uli>
To: Adrian Daminato <adrian@tucows.com>
cc: ZipKid <stefan@zipkid.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: hiding arp for server farms
Message-ID: <Pine.LNX.4.33.0111290148120.1111-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Adrian Daminato wrote:

> 3) I even tried adding the 'hidden' patch available, to put the hidden
> functionality back in the 2.4.x kernel (currently I'm testing using a 2.4.9
> kernel).  It doesn't appear to work properly either, hosts on the local network
> can't ping the server farm, and hosts outside the network although able to ping
> the server farm, cannot ping the real IP of the host.  It's kind of a weird
> problem.

	As this thread becomes too large I'm appending some
URLs. I don't know what patches you are using and what settings
you have. If you still have problems feel free to contact me directly.
The usage is simple: mark device "lo" as hidden and put there only
local addresses that must not advertised.

The "hidden" device's home page:
http://www.linuxvirtualserver.org/~julian/

Doc files:
http://www.linuxvirtualserver.org/~julian/hidden.txt
http://www.linuxvirtualserver.org/docs/arp.html

Regards

--
Julian Anastasov <ja@ssi.bg>

