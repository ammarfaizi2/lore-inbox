Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271592AbRHPQcd>; Thu, 16 Aug 2001 12:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271591AbRHPQcX>; Thu, 16 Aug 2001 12:32:23 -0400
Received: from as2-4-3.an.g.bonet.se ([194.236.34.191]:20974 "EHLO
	cosmo.zigo.dhs.org") by vger.kernel.org with ESMTP
	id <S271590AbRHPQcL>; Thu, 16 Aug 2001 12:32:11 -0400
Date: Thu, 16 Aug 2001 18:32:23 +0200 (CEST)
From: Dennis Bjorklund <db@zigo.dhs.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.19: d-link dfe530-tx, Transmit timed out
Message-ID: <Pine.LNX.4.33.0108161810440.18106-100000@cosmo.zigo.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a d-link dfe530-tx that goes mad when there is heavy load on
the network and and stops working. The heavy traffic is not to this
computer but between other computers on the network. I use the 2.2.19
kernel that redhat have built for rh 6.2.

This is the log

kernel: via-rhine.c:v1.08b-LK1.0.0 12/14/2000  Written by Donald Becker
kernel:   http://www.scyld.com/network/via-rhine.html
kernel: eth1: VIA VT6102 Rhine-II at 0xe400, 00:50:ba:6e:76:63, IRQ 9.
kernel: eth1: MII PHY found at address 8, status 0x782d advertising 01e1 Link 40a1.
[...]
kernel: eth1: Transmit timed out, status 0000, PHY status 782d, resetting..
(a lot of these)

I know this thread was up a year ago but there doesn't seem to have been a
solution.  I also remember that there where patches that was supposed to
reset the card when this happens, but obviously they never got into the
kernel.

What happened to these patches, do they live somewhere outside the
kernel?

I should probably throw out this stupid card and get something else. Any
suggestion of a card working well in linux? The computer is a P90 so a
card that uses little cpu would be good. If I have to buy I can just as
well buy something that works well in linux. Maybe I should get the same
cards that Alan or Linus uses :-) They ought to work in the future I
guess..

-- 
/Dennis

