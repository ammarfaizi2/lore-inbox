Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281864AbRKSAZn>; Sun, 18 Nov 2001 19:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281861AbRKSAZd>; Sun, 18 Nov 2001 19:25:33 -0500
Received: from gedeon.silesia.pik-net.pl ([213.186.64.2]:27653 "EHLO
	gedeon.silesia.pik-net.pl") by vger.kernel.org with ESMTP
	id <S281866AbRKSAZT>; Sun, 18 Nov 2001 19:25:19 -0500
Date: Mon, 19 Nov 2001 01:25:16 +0100
From: Grzegorz Paszka <Grzegor@Paszka.com>
To: linux-kernel@vger.kernel.org
Subject: 1.5 GB memory problem with 2.4.x
Message-ID: <20011119012515.A27753@pik-net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've RH7.1 with updates and kernel 2.4.14 from tgz, root filesystem is on
software raid1.
Hardware: 1.5 GB RAM, asus cuv4x-e, via chipset (host bridge: VT82C693A/694x).
Kernel is compiled with support for more then 1GB memory. (4GB).

I've tested this hardware with memtest86 (ver. 2.8) and everything looks good.

But linux is unstable. Mysql reports corrupted databases. I get crc
errors when I try ungzip zipped files. Programs dump cores from time to
time. And my linux box hanged one time.

I've tryed 2.4.7 kernel with no support for more then 1GB memory (linux see
about 900MB memory) but problems still appear.

Finally I've only 512MB RAM and linux looks stable with 2.4.7 and 2.4.14.

What I should do to have stable linux with 1.5GB RAM ?

Should I try to redhat kernel-2.4.9-enterprise ? (My / is on raid1 so I don't
know is it possible)

I'm not subscribed on this list.
-- 
Grzegorz
