Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287757AbSAKINC>; Fri, 11 Jan 2002 03:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289894AbSAKIMw>; Fri, 11 Jan 2002 03:12:52 -0500
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:60581
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S287757AbSAKIMi>; Fri, 11 Jan 2002 03:12:38 -0500
Message-ID: <3C3E9E64.3050506@debian.org>
Date: Fri, 11 Jan 2002 09:12:20 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Martin Eriksson <nitrax@giron.wox.org>,
        Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
In-Reply-To: <fa.eln67tv.a4io16@ifi.uio.no> <fa.gp0gofv.1p4se16@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>Just curious; is RPM a "standard" for most linux distros now? I have always
>>been running RedHat so I wouldn't know.
>>
> 
> Most but not all. Debian has a very powerful package system that is quite
> different for example. I don't know if the Debian package setup protects
> you from installing i686 binaries on an i486, but I bet within 48 hours of
> this discussion it will do anyway


Debian doesn't have this feature.
Debian policy tell us: i386 is fine. Performance gain is minimal (or nothing)
so compile with in i386 compatible mode.
(on package that performance matter, there exists an optional package with
an extra suffix (i.e. 686). So user can choice the more performant
package (but not the default)).
But numbers (profiles) have told us that such package are less then 1
every 1000.

[In debian-devel list this is a frequent flamewar. But until we have
'number' that told us to add a PPro optimization, we don't move.
Debian have not the the marketing need of other distributions.
(We are are the best distribution :-) ) ]

	giacomo





