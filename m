Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132044AbRDNMM3>; Sat, 14 Apr 2001 08:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132046AbRDNMMT>; Sat, 14 Apr 2001 08:12:19 -0400
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:18566 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S132044AbRDNMMO>;
	Sat, 14 Apr 2001 08:12:14 -0400
Date: Sat, 14 Apr 2001 14:12:08 +0200
From: Stefan Traby <stefan@hello-penguin.com>
To: Andi Kleen <ak@suse.de>
Cc: Dave <daveo@osdn.com>, linux-kernel@vger.kernel.org
Subject: Re: bizarre TCP behavior
Message-ID: <20010414141208.A31782@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <Pine.LNX.4.33.0104101809190.1468-100000@meatloop.andover.net> <20010411022142.A28926@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010411022142.A28926@gruyere.muc.suse.de>; from ak@suse.de on Wed, Apr 11, 2001 at 02:21:42AM +0200
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.3 (i686)
X-APM: 100% 400 min
X-MIL: A-6172171143
X-Lotto: Suggested Lotto numbers (Austrian 6 out of 45): 4 15 25 27 28 37
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 02:21:42AM +0200, Andi Kleen wrote:

> Try echo 0 > /proc/sys/net/ipv4/tcp_ecn
> If it helps complain to the sites that their firewall is broken.

Not always firewall related.
There are companies like Zyxel that ship broken router
too.

For example the Zyxel 681 SDSL-Router breaks ECN by
stripping 0x80 (ECN Cwnd Reduced) but not 0x40 (ECN Echo)
(TOS bits) on all SYN packets (!).

I complained because of this two times more than a month ago
but they do not even respond.

I do not know if they are unable or just unwilling to fix it;
maybe they just unable to read RFC's.

-- 

  ciao - 
    Stefan
