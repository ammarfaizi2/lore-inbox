Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbRFZWin>; Tue, 26 Jun 2001 18:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265142AbRFZWid>; Tue, 26 Jun 2001 18:38:33 -0400
Received: from lithium.nac.net ([64.21.52.68]:52493 "HELO lithium.nac.net")
	by vger.kernel.org with SMTP id <S265135AbRFZWiY>;
	Tue, 26 Jun 2001 18:38:24 -0400
Date: Tue, 26 Jun 2001 18:38:09 -0400
To: linux-kernel@vger.kernel.org
Subject: Swap error message I've seen in 2.4.5-ac17
Message-ID: <20010626183808.A905@debian>
In-Reply-To: <20010623222954.A9031@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010623222954.A9031@debian>
User-Agent: Mutt/1.3.18i
From: <tcm@nac.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, me again. I've been playing around with ac17 on my old 486 machine
for a few days (it seems strange that the 486 works fine while the K6
doesn't, but I digress) and I noticed today something that made my hair
stand on end:

Jun 26 16:17:27 debian kernel: VM: Bad swap entry 0033da00
Jun 26 16:17:27 debian kernel: Unused swap offset entry in swap_count
0033da00
Jun 26 16:17:27 debian kernel: Unused swap offset entry in swap_count
0033da00
Jun 26 16:38:16 debian -- MARK --
Jun 26 16:53:13 debian kernel: PPP BSD Compression module registered
Jun 26 16:53:14 debian kernel: PPP Deflate Compression module registered
Jun 26 16:53:24 debian kernel: VM: Bad swap entry 0033da00

Now I have been told by Rik Van Riel that this is a kernel bug - I
initially figured it was a bad disk, thanks to him I can breathe now...

Anyway, at the time the kernel did these messages I was just stopping
playing quake on my K6-III (486 handles packets to/from the modem) and
was reloading the compression modules, changing the mtu of my modem's 
interface to 1500 from 576, and starting fetchmail. And about one
minute later I decided to simply disconnect.

I can't seem to find a way to reproduce this problem all the time like I
can with the freezing bug, but I will reply to this thread if I see it
again and/or can repeatedly reproduce it.
