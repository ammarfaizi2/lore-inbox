Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312003AbSCQKAc>; Sun, 17 Mar 2002 05:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312002AbSCQKAW>; Sun, 17 Mar 2002 05:00:22 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:10732 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S312001AbSCQKAJ>; Sun, 17 Mar 2002 05:00:09 -0500
Date: Sun, 17 Mar 2002 11:00:08 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
Message-ID: <20020317110008.A21369@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020315223649.AAA27488@shell.webmaster.com@whenever> <20020315.145306.15914579.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020315.145306.15914579.davem@redhat.com>; from davem@redhat.com on Fri, Mar 15, 2002 at 10:57:11PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 10:57:11PM +0000, David S. Miller wrote:
> 
> There is no reason to not be doing this MD5 garbage in
> userspace.  Whoever thought to do this in the protocol
> itself was smoking something.

I did a lot of this using an iptables module. Iptables lends itself very
well to these kind of things. Toy code at http://ds9a.nl/sps/

> Maybe I'm missing something, but I see no reason this MD5
> stuff belongs in the protocol and not in the APP.

Some of the idea is cool. You can give a host a 'key' and tell your packet
filter to have it pass packets signed with that key. This way you can grant
or disable access on a very low level without depending on IP addresses,
which can be spoofed.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
