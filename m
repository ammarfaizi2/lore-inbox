Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131226AbRCTW11>; Tue, 20 Mar 2001 17:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131227AbRCTW1S>; Tue, 20 Mar 2001 17:27:18 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:26636 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131226AbRCTW1F>; Tue, 20 Mar 2001 17:27:05 -0500
Date: Tue, 20 Mar 2001 19:19:30 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory leak in 2.4.2 (+loop-6-patch)???
In-Reply-To: <Pine.LNX.4.20.0103202155030.3879-100000@citd.owl.de>
Message-ID: <Pine.LNX.4.21.0103201919080.3750-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001, Matthias Schniedermeyer wrote:

> After some days of uptime, i just stopped (nearly) all programs,
> unmounted all unnecessary devices.
> 
> But top & free say that 1/3 of my RAM is still "used"

grep cache < /proc/slabinfo
grep buffer < /proc/slabinfo

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

