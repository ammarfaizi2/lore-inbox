Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264693AbSJUCYB>; Sun, 20 Oct 2002 22:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264694AbSJUCYA>; Sun, 20 Oct 2002 22:24:00 -0400
Received: from rth.ninka.net ([216.101.162.244]:51594 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S264693AbSJUCX7>;
	Sun, 20 Oct 2002 22:23:59 -0400
Subject: Re: [Design] [PATCH] USAGI IPsec
From: "David S. Miller" <davem@rth.ninka.net>
To: Sandy Harris <sandy@storm.ca>
Cc: Mitsuru KANDA <mk@linux-ipv6.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, cryptoapi-devel@kerneli.org,
       design@lists.freeswan.org, usagi@linux-ipv6.org
In-Reply-To: <3DB41338.3070502@storm.ca>
References: <m3k7kpjt7c.wl@karaba.org>  <3DB41338.3070502@storm.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Oct 2002 19:41:06 -0700
Message-Id: <1035168066.4817.1.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this code being checked in to the mainline kernel? Or becoming part 
> of the
> CryptoAPI patch set? Bravo, in either case.

We will be incorporating lots of ideas and small code pieces
from USAGI's work, but most of the core engine will be a new
implementation.

A completely new CryptoAPI subsystem has been implemented so that
full lists of page vectors can be passed into the ciphers, which is
necessary for a clean IPSEC implementation.

It is intended that this work will be complete (it isn't done as I
type this) and pushed to Linus upon his return from vacation.

