Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWFIJhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWFIJhX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 05:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWFIJhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 05:37:23 -0400
Received: from dee.erg.abdn.ac.uk ([139.133.204.82]:60304 "EHLO erg.abdn.ac.uk")
	by vger.kernel.org with ESMTP id S932346AbWFIJhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 05:37:22 -0400
From: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Organization: Electronics Research Group, UoA
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2.6.17-rc6-mm1 ] net: RFC 3828-compliant UDP-Lite support
Date: Fri, 9 Jun 2006 10:36:41 +0100
User-Agent: KMail/1.8.3
Cc: jmorris@namei.org, alan@lxorguk.ukuu.org.uk, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060608.115331.71094388.davem@davemloft.net> <200606082109.34338.gerrit@erg.abdn.ac.uk> <20060608.151347.55505744.davem@davemloft.net>
In-Reply-To: <20060608.151347.55505744.davem@davemloft.net>
X-Face: ,l9N8F.A~!GX.Yz#yYAZtvpk7aF(an!BVo3%Xb,`Q]*$Oh'RtXB5n4iisiGw8l3nY)lnh(=?utf-8?q?=0A=09G=5D9=5Bud=3BQeX=3AW=7D=27r?=)1F9gEQD4o::mBU9JZAXI\y_0t$P#*/o|!TSG9OtqY+`NX>=?utf-8?q?cpjf=3Fw=7Ew=0A=091RY=5F=7DM5731El52pUnI=7DOaRi=7EPA+n=5BfiO?=>=TS|2h~f%c9zy]*i2LajTWLJ_X^1No"P#D_(=?utf-8?q?t=0A=09*t-5n=5DwW1?=
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606091036.42075.gerrit@erg.abdn.ac.uk>
X-ERG-MailScanner: Found to be clean
X-ERG-MailScanner-From: gerrit@erg.abdn.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Miller:
|  From: Gerrit Renker <gerrit@erg.abdn.ac.uk>
|  Date: Thu, 8 Jun 2006 21:09:33 +0100
|  
|  > That is why I held back regarding the IPv6 port:
<snip> 
|  
|  It's not like an ipv6 port is such a big pile of work.
|  
I see the point and will port to v6 (have asked colleages for help). 
Until then, I will keep an up-to-date (-mm) patch in the tarball

http://www.erg.abdn.ac.uk/users/gerrit/udp-lite/files/udplite_linux.tar.gz

This has applications as well. I would value any more input: the suggestion to 
use SOCK_DGRAM has already been integrated and proved a really good idea (much less 
to patch, cleaner code). Usually an update is there on the same day the new kernel 
comes out.
Thank you for your replies and comments, I will be back when the v6 side is ready.
