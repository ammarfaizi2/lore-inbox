Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280988AbRKCQuJ>; Sat, 3 Nov 2001 11:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280989AbRKCQuB>; Sat, 3 Nov 2001 11:50:01 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:60328 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S280988AbRKCQtq>; Sat, 3 Nov 2001 11:49:46 -0500
Date: Sat, 3 Nov 2001 17:49:45 +0100
From: bert hubert <ahu@ds9a.nl>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org, khttpd mailing list <khttpd-users@zgp.org>
Subject: Re: khttpd vs tux
Message-ID: <20011103174945.A16538@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	linux-kernel@vger.kernel.org,
	khttpd mailing list <khttpd-users@zgp.org>
In-Reply-To: <20011103172803.A16411@outpost.ds9a.nl> <Pine.LNX.4.30.0111031744280.8812-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0111031744280.8812-100000@mustard.heime.net>; from roy@karlsbakk.net on Sat, Nov 03, 2001 at 05:45:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2001 at 05:45:29PM +0100, Roy Sigurd Karlsbakk wrote:
> > tux holds all records, khttpd has been measured to be slower than some
> > userspace webservers.
> 
> What's bad about tux, then? There usually is something...

The main hurdle for Tux is that it is not in the mainstream kernel, and
consists of a patch. I think RedHat has precompiled kernels with Tux in
them. The aa kernels also contain tux.

There are also strong indications that 'zero copy tcp/ip' may enable
userspace webservers to achieve comparable bandwidths (many gbits/second).
See for example X15: http://www.chromium.com/x15tech.html

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
Trilab                                 The Technology People
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
