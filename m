Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317713AbSFLOuA>; Wed, 12 Jun 2002 10:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317714AbSFLOt7>; Wed, 12 Jun 2002 10:49:59 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:2576 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S317713AbSFLOt6>; Wed, 12 Jun 2002 10:49:58 -0400
Date: Thu, 13 Jun 2002 00:52:13 +1000
From: john slee <indigoid@higherplane.net>
To: Lincoln Dale <ltd@cisco.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: per-socket statistics on received/dropped packets
Message-ID: <20020612145212.GF27429@higherplane.net>
In-Reply-To: <greearb@candelatech.com> <3D06E9A0.5060801@candelatech.com> <5.1.0.14.2.20020612221925.0283fb18@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ trimmed cc ]

On Wed, Jun 12, 2002 at 10:28:15PM +1000, Lincoln Dale wrote:
> right now, those bills are anywhere between 10% to 25% incorrect.

10-25% is roughly equivalent to the hit rates i've seen on my web caches
in real life, with MANY users.  i can't believe people are actually
using this for data accounting.

i also can't think of many decent "free" (whatever your interpretation
of that is) ways to do it either.  interface packet counters wrap
around, most commercial firewalls i've used have inaccurate or
incomplete logging (to put it lightly), and packet sniffers sometimes
can't keep up.

surely if profit (or just keeping your head above the water) is the goal
you can justify the necessary resources to use something like netflow, a
product designed to do exactly what you seem to want, among other
things.  (search cisco.com, and no, i'm not a cisco employee)

fiddling the network stack so that you can do dubious hacks in an
allegedly apparently dubious aspect of squid just doesn't seem to be the
ideal way to fix this problem.

regards,

j.

-- 
toyota power: http://indigoid.net/
