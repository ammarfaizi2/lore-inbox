Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313943AbSEFA77>; Sun, 5 May 2002 20:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313946AbSEFA76>; Sun, 5 May 2002 20:59:58 -0400
Received: from c9mailgw01.amadis.com ([216.163.188.202]:525 "EHLO
	C9Mailgw03.amadis.com") by vger.kernel.org with ESMTP
	id <S313943AbSEFA75>; Sun, 5 May 2002 20:59:57 -0400
Message-ID: <3CD5D57D.DED89DFC@starband.net>
Date: Sun, 05 May 2002 20:59:41 -0400
From: Justin Piszcz <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux & X11 & IRQ Interrupts
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I move the mouse under X11 I hear a buzzing sound in the computer,
first, I found it was the console speaker.

Yet, I still hear a very faint sound when I move the mouse cursor, this
is after I've disconnected the console speaker, no matter what the rate
of interrupts.

from itop:

INT                NAME          RATE             MAX
  0 [             timer]   101 Ints/s     (max:   101)
  1 [          keyboard]     1 Ints/s     (max:     1)
  5 [              eth0]     2 Ints/s     (max:     4)
 12 [        PS/2 Mouse]   276 Ints/s     (max:   276)

Other people have also reported this problem but there hasn't been an
apparent fix for it yet?

With the console speaker attached, it can be clearly heard, as well as
performing fast packet movements (nmap (with insane option)) or such you
can literally hear the packets.

When I am compiling an application or spending interrupts on disk
access (copying files/doing a find), moving the mouse/holding a key on
the keyboard does not make noise.

Does anyone know the source of this problem, and possibly a solution, or
something one can do to mute this annoying noise?

This noise does not occur in any version of MS windows, so I am curious
as to what the kernel? or x11? is doing to produce this noise?


