Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317757AbSGVQzq>; Mon, 22 Jul 2002 12:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317759AbSGVQzq>; Mon, 22 Jul 2002 12:55:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:13696 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317757AbSGVQzp>; Mon, 22 Jul 2002 12:55:45 -0400
Date: Mon, 22 Jul 2002 12:59:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: venom@sns.it
cc: Karol Olechowski <karol_olechowski@acn.waw.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: Athlon XP 1800+ segemntation fault
In-Reply-To: <Pine.LNX.4.43.0207221829530.29205-100000@cibs9.sns.it>
Message-ID: <Pine.LNX.3.95.1020722125325.6785A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002 venom@sns.it wrote:

> As almost 97% of people on this list will write you, run memtest for a
> night and check your memory.


> gcc: Internal compiler error:
> program cc1 got fatal signal 11
> make[3] : ***[igmp.o] Error 1

99.9999% probability memory error. This may not be 'bad' memory, but
memory that is running on a front-side bus at a speed for which it
was not designed. --And many board-vendors don't know the difference.
As a temporary 'fix', if your BIOS or board pin-headers provide a
100 MHz setting for the memory-bus, set it and see if it works.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

