Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265049AbSKAP2m>; Fri, 1 Nov 2002 10:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265050AbSKAP2m>; Fri, 1 Nov 2002 10:28:42 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:21981 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S265049AbSKAP2l>;
	Fri, 1 Nov 2002 10:28:41 -0500
Date: Fri, 1 Nov 2002 16:35:09 +0100
From: bert hubert <ahu@ds9a.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021101153508.GA10277@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <20021031181252.GB24027@tapu.f00f.org> <Pine.LNX.4.44.0210311040080.1526-100000@penguin.transmeta.com> <20021031194351.GA24676@tapu.f00f.org> <apu6cd$4db$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apu6cd$4db$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 03:25:01PM +0000, Linus Torvalds wrote:


> (copy-in and copy-out, and that's so theoretical that it's not even
> funny - I'd be surprised if RL throughput copying back and forth over a
> PCI bus is more than 25-30MB/s), I suspect that you can do most crypto
> faster on the CPU directly these days. 

I'd be amazed of current CPUs would be able to do asymmetric encryption at
anywhere within an order of magnitude of those rates.

Symmetric encryption is something else. This is the reason many encryption
products (ie, pgp) only use asymmetric encryption for encrypting a symmetric
session key, and not encrypting the entire message.

Regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
