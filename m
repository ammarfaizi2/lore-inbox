Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271765AbRHURv7>; Tue, 21 Aug 2001 13:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271767AbRHURvt>; Tue, 21 Aug 2001 13:51:49 -0400
Received: from ip-a1-37024.keycomm.it ([62.152.37.24]:35174 "EHLO
	gauss.campana.vi.it") by vger.kernel.org with ESMTP
	id <S271765AbRHURvh>; Tue, 21 Aug 2001 13:51:37 -0400
Date: Tue, 21 Aug 2001 19:52:46 +0200
From: Ottavio Campana <bott@iol.it>
To: linux-kernel@vger.kernel.org
Subject: esssolo1 driver strange behaviuor
Message-ID: <20010821195246.A1681@campana.vi.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux gauss 2.2.19 
X-Organization: Lega per la soppressione del Visual Basic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I just  compiled linux  2.4.9 on my  laptop. It has  got a  solo-1 based
sound card. I've tried to compile  the kernel with the static support of
the card  and, for  it is  a laptop and  it hasn't  got any  gameport, I
didn't selected any joystick support.

The   kernel   cannot   compile,   I've   got   a   linking   error   in
/usr/src/linux/drivers/sound/soundcore.o  because  it  cannot  find  the
functions  gameport_register_port and  gameport_unregister_port  . If  I
compile the driver as a module it is compiled succesfully and it works.

I've looked at /usr/src/linux/drivers/sound/esssolo1.c and commented out
the two lines (2378 and 2423)  that call the 2 functions for registering
and unregistering  the gameport and  the driver compiles  statically and
works.

I know this  is just a little hack,  but I want to bring note  to you of
this problem that I have found even with earlier 2.4 kernels (I've tryed
2.4.5 , 2.4.6 and 2.4.8).

I hope this email could be useful otherwise please excuse me.

Bye

PS: I don't have got the time  for following the mailing list so can you
please cc any reply to bott@iol.it? Thank you.

-- 
Non c'è più forza nella normalità, c'è solo monotonia.
