Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266513AbSKGKca>; Thu, 7 Nov 2002 05:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266515AbSKGKca>; Thu, 7 Nov 2002 05:32:30 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:10437 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S266513AbSKGKc0>;
	Thu, 7 Nov 2002 05:32:26 -0500
Date: Thu, 7 Nov 2002 11:39:05 +0100
From: bert hubert <ahu@ds9a.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Silly advise in bridge Configure help
Message-ID: <20021107103905.GA22139@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <3DC9EA2A.142559AA@verizon.net> <20021107.011526.120464470.davem@redhat.com> <20021107091822.GA21030@outpost.ds9a.nl> <20021107.014953.58440275.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107.014953.58440275.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you take Linus's current BK tree, and apply the patch below, you
> can begin trying to use the racoon and other KAME tools that we
> 'ported' at:

This also appears to need some changes in the crypto api:
1 out of 1 hunk FAILED -- saving rejects to file crypto/Kconfig.rej
2 out of 4 hunks FAILED -- saving rejects to file crypto/tcrypt.c.rej
1 out of 10 hunks FAILED -- saving rejects to file net/key/af_key.c.rej

missing |diff -Nru a/crypto/sha256.c b/crypto/sha256.c
missing |diff -Nru a/crypto/blowfish.c b/crypto/blowfish.c

> 	ftp://ftp.inr.ac.ru/ip-routing/ipsec/
> 
> I'll be sending this set of changes to him tonight.
> 
> Have fun :-)

Oh I will :-)

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
