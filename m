Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270847AbRIJM0D>; Mon, 10 Sep 2001 08:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270814AbRIJMZy>; Mon, 10 Sep 2001 08:25:54 -0400
Received: from spike.porcupine.org ([168.100.189.2]:55055 "EHLO
	spike.porcupine.org") by vger.kernel.org with ESMTP
	id <S270797AbRIJMZm>; Mon, 10 Sep 2001 08:25:42 -0400
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
In-Reply-To: <20010910100537.W26627@khan.acc.umu.se> "from David Weinehall at
 Sep 10, 2001 10:05:37 am"
To: David Weinehall <tao@acc.umu.se>
Date: Mon, 10 Sep 2001 08:26:03 -0400 (EDT)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Wietse Venema <wietse@porcupine.org>,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, netdev@oss.sgi.com
X-Time-Zone: USA EST, 6 hours behind central European time
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010910122603.80CA4BC06C@spike.porcupine.org>
From: wietse@porcupine.org (Wietse Venema)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall:
> Are you saying that Linux should implement compability with _new_
> features in FreeBSD 4.x, while at the same time frowning at the fact
> that Linux introduces a new API?! The mind boggles at the thought.

SIOCGIFNETMASK is not "new". It exists in systems as ancient as
SunOS 4.x, which pre dates FreeBSD 4.x by about 10 years. 

Evidence: RTFM the Postfix source code :-)

In other words, SIOCGIFNETMASK existed long before Linux could plug
into a network.

	Wietse
