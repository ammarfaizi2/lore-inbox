Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276021AbRJGBYJ>; Sat, 6 Oct 2001 21:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275994AbRJGBX7>; Sat, 6 Oct 2001 21:23:59 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:59664 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S275990AbRJGBXs>;
	Sat, 6 Oct 2001 21:23:48 -0400
Date: Sat, 6 Oct 2001 22:23:56 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, <linux-xfs@oss.sgi.com>
Subject: Re: %u-order allocation failed
In-Reply-To: <Pine.LNX.3.96.1011007003227.18004B-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33L.0110062223210.2847-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Oct 2001, Mikulas Patocka wrote:

> You are right. Code that allocates more than page and expects it to be
> physicaly contignuous is broken by design. Even rewrite the driver or
> allocate memory on boot. It will be very hard to audit all drivers for it.

Better buy us all new hardware, then ;)

Some devices really do want physically contiguous buffers
for DMA...


Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

