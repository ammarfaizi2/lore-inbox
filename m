Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbSKHNhX>; Fri, 8 Nov 2002 08:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261955AbSKHNhX>; Fri, 8 Nov 2002 08:37:23 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:44482 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261950AbSKHNhW>;
	Fri, 8 Nov 2002 08:37:22 -0500
Date: Fri, 8 Nov 2002 14:44:04 +0100
From: bert hubert <ahu@ds9a.nl>
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, mdiehl@dominion.dyndns.org, linux-kernel@vger.kernel.org,
       gem@asplinux.ru
Subject: Re: [documentation] Re: [LARTC] IPSEC FIRST LIGHT! (by non-kernel developer :-))
Message-ID: <20021108134404.GA23148@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, kuznet@ms2.inr.ac.ru,
	davem@redhat.com, mdiehl@dominion.dyndns.org,
	linux-kernel@vger.kernel.org, gem@asplinux.ru
References: <20021108122523.GA21075@outpost.ds9a.nl> <200211081331.QAA12531@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211081331.QAA12531@sex.inr.ac.ru>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 04:31:29PM +0300, kuznet@ms2.inr.ac.ru wrote:

> > Kernel enters a very tight loop here, I'm amazed that magic sysrq still
> > works, how is that?
> 
> Yes, this is sort of inefficient loop. :-)

> +		child = child->child;

I had 'child=child->next;' here, which worked, but may be wrong.

By the way, have your thoughts included 'UDP Encapsulation of IPsec Packets' 
http://www.ietf.org/internet-drafts/draft-ietf-ipsec-udp-encaps-04.txt so
far?

Not sure if this would break your pretty design :-) It would just *rock* for
traversing NAT.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
