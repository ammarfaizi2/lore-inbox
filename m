Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267652AbTGHVR0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 17:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267666AbTGHVR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 17:17:26 -0400
Received: from mithril.c-zone.net ([63.172.74.235]:16396 "EHLO mail.c-zone.net")
	by vger.kernel.org with ESMTP id S267652AbTGHVRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 17:17:25 -0400
Message-ID: <3F0B386F.3080902@c-zone.net>
Date: Tue, 08 Jul 2003 14:32:31 -0700
From: jiho@c-zone.net
Organization: Kidding of Course
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: hdX lost interrupt problem
References: <3F0AE4DF.80808@ifrance.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cédric Barboiron wrote:

  > Hello,
  >
  > I'm currently having troubles while trying to listen or rip cds
  > audios. `cdparanoia -Q` works fine but `strace cdparanoia 1` hangs
  > at : ioctl(3, 0x530e
  >
  > Then I have from `dmesg` : hdc: lost interrupt hdc: lost interrupt (...)
  >

  > hdc: lost interrupt hdc: lost interrupt
  >
  > The only thing I found in archives is : " It seems like the 'lost
  > interrupt' while ripping audio CDs is specific to VIA based
  > motherboards."
  >
  > In fact, I have a VIA based motherboard : VIA KT333 and VIA 8233A

What kind of hard drive is it, with which kind of cable (40-line or
80-line), and what transfer mode is it running in?

These "lost interrupt" problems date back to UDMA-33.  There were tons
of them early on, with several OSes, and if I'm not mistaken the
association seemed to be more with case cooling issues and ribbon
cables, rather than any particular chipset.

That *seemed* to be true in my case (and in my case), but I don't have
absolute knowledge of that because the problem was rare and impossible
to reproduce on demand.  I had a VIA chipset, 82C586B, but there were
clear issues with case cooling, and the problem *seemed* to go away when
those issues were addressed.  That *seemed* to be true for the other
cases (and cases) I read about, as well.

Maybe people with VIA chipsets tend to be reckless with their case
setups....


-- Jim Howard  <jiho@c-zone.net>


