Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262911AbSJLMLC>; Sat, 12 Oct 2002 08:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262912AbSJLMLC>; Sat, 12 Oct 2002 08:11:02 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:37046 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S262911AbSJLMLB>;
	Sat, 12 Oct 2002 08:11:01 -0400
Date: Sat, 12 Oct 2002 14:16:50 +0200
From: bert hubert <ahu@ds9a.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] USAGI IPsec
Message-ID: <20021012121650.GA10827@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
References: <20021012.114330.78212112.yoshfuji@linux-ipv6.org> <20021011.194108.102576152.davem@redhat.com> <20021012111759.GA10104@outpost.ds9a.nl> <20021012.044137.42774593.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021012.044137.42774593.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 04:41:37AM -0700, David S. Miller wrote:

> Also the idea Alexey and I have to move towards a small
> efficient flow cache shared by IPv4/IPv6 plays into this
> as well.  There are changesets on their way to Linus tonight

Some people on #lartc were wondering about the use of a route cache if there
is only one route. It was reported that a single default route on a system
that talks to many destinations would lead to a huge route cache, which is
probably not more efficient than looking up the simple route.

Would this 'small efficient flow cache' also solve this problem?

Or is this problem a figment of people's imaginations?

> The initial ipsec is intended to be simple, singly linked
> lists for the spd/sad databases etc.  Making the feature
> freeze is pretty important right now, full blown flow cache
> is just performance improvement :)

I know a lot of people are hoping that you make the feature freeze. As said
before, if there is any help you need, just yell.

Regards,

bert 

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
