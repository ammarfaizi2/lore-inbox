Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286138AbRLJBOS>; Sun, 9 Dec 2001 20:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286131AbRLJBMt>; Sun, 9 Dec 2001 20:12:49 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:30417 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S286128AbRLJBMD>; Sun, 9 Dec 2001 20:12:03 -0500
Date: Mon, 10 Dec 2001 02:12:00 +0100
From: bert hubert <ahu@ds9a.nl>
To: jamal <hadi@cyberus.ca>
Cc: kuznet@ms2.inr.ac.ru, lartc@mailman.ds9a.nl, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: CBQ MANPAGE: I hear the theme of '2001, A Space Odyssey'
Message-ID: <20011210021200.A27995@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, jamal <hadi@cyberus.ca>,
	kuznet@ms2.inr.ac.ru, lartc@mailman.ds9a.nl,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20011210014130.A27193@outpost.ds9a.nl> <Pine.GSO.4.30.0112092001180.6079-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.30.0112092001180.6079-100000@shell.cyberus.ca>; from hadi@cyberus.ca on Sun, Dec 09, 2001 at 08:04:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2001 at 08:04:42PM -0500, jamal wrote:

> Sorry didnt read it; did the 30 sec scan ..
> If this is meant to be for users, why are you talking about skb->priority?
> Isnt it sufficient to just call it prioirity?

It's not done yet and may need some readability tuning. Note however that
skb->priority is a bit overloaded. It can contain a priority, but also a
32bit encoded classid. These are different things, so they deserve different
mention.

> Also, if you think that Alexeys imp. is based on Floyd only, you are
> highly mistaken;

I just copied the attribution from the kernel, am glad to rectify things.

> Going back to high latency response mode ...

Thanks for reviewing.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
Trilab                                 The Technology People
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
