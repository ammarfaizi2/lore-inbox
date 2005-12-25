Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbVLYVJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbVLYVJR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 16:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVLYVJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 16:09:17 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59590 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750926AbVLYVJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 16:09:17 -0500
Date: Sun, 25 Dec 2005 22:09:13 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: LKML <linux-kernel@vger.kernel.org>, Stelian Pop <stelian@popies.net>
Subject: Re: [RFT] Sonypi: convert to the new platform device interface
In-Reply-To: <d120d5000512131104x260fdbf2mcc58fb953559fec5@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0512252207020.15152@yvahk01.tjqt.qr>
References: <200512130219.41034.dtor_core@ameritech.net> 
 <20051213183248.GA3606@inferi.kami.home> <d120d5000512131104x260fdbf2mcc58fb953559fec5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > The patch compiles but I was unable to test it since I don't have the
>> > hardware...
>>
>> other than that seems to work here on a type2 model:

It does not work here on a SONY VAIO U3. After loading the sonypi module, 
neither mev nor showkey return something for the special stuff like 
jogwheel, jogbutton or Fn keys respectively.

Running 2.6.15-rc7, this appeared in the kernel log:
Dec 25 22:06:14 takeshi kernel: sonypi: request_irq failed


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
