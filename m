Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLEUKw>; Tue, 5 Dec 2000 15:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLEUKm>; Tue, 5 Dec 2000 15:10:42 -0500
Received: from main.cyclades.com ([209.128.87.2]:56841 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S129210AbQLEUKb>;
	Tue, 5 Dec 2000 15:10:31 -0500
Date: Tue, 5 Dec 2000 11:40:02 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: "Matthew G. Marsh" <mgm@paktronix.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
In-Reply-To: <Pine.LNX.4.10.10012050835370.1199-100000@netmonster.pakint.net>
Message-ID: <Pine.LNX.4.10.10012051138490.1713-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Dec 2000, Matthew G. Marsh wrote:
> 
> I would like to note an objection to using ifconfig to carry all of this.
> For example I do not use or even have ifconfig on any of my systems as I
> only use/need/want Alexey's ip utility to perform all of those tasks. 
> 
> I would rather have an independant utility that could set and check the
> settings of all of these variables for whatever classes of networking
> connections existed. This would provide a cleaner split between the
> protocol configuration (IPv4, IPv6, IPX, ...) and the device (V.##,
> 10/100, 4/16/100, etc) parameters. 
> 
> Such a split should make for a cleaner configuration structure WRT virtual
> devices as well which for the most part deal with the protocol config and
> do not need much device config. 
> 
> FWIW: Alexey's ip has replaced both ifconfig and route on my systems.
> Something that could now replace having several different card config
> utils around with one binary would be fantastic.

Very good point IMHO. I'll have a look at ip to see if I can get ideas
from it. Thanks for the info!!

Later,
Ivan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
