Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271214AbRIGFtN>; Fri, 7 Sep 2001 01:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271230AbRIGFtE>; Fri, 7 Sep 2001 01:49:04 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:41163 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S271214AbRIGFsv>;
	Fri, 7 Sep 2001 01:48:51 -0400
Message-ID: <3B985FC6.B41000A3@candelatech.com>
Date: Thu, 06 Sep 2001 22:48:54 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip 
 aliasbug 2.4.9 and 2.2.19]
In-Reply-To: <20010906212303.A23595@castle.nmd.msu.ru> <20010906173948.502BFBC06C@spike.porcupine.org> <9n8ev1$qba$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:

> In autofs, I use the following technique to determine if the IP number
> for a host is local (and therefore vfsbinds can be used rather than
> NFS mounts):
> 
> connect a datagram socket (which won't produce any actual traffic) to
> the remote host with INADDR_ANY as the local address, and then query
> the local address.  If the local address is the same as the remote
> address, the address is local.

That will always work, even when you have multiple ethernet
interfaces??

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
