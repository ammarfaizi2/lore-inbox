Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSHATVW>; Thu, 1 Aug 2002 15:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316855AbSHATVW>; Thu, 1 Aug 2002 15:21:22 -0400
Received: from zeppo.NMSU.Edu ([128.123.29.173]:27268 "EHLO zeppo.NMSU.Edu")
	by vger.kernel.org with ESMTP id <S316683AbSHATVV> convert rfc822-to-8bit;
	Thu, 1 Aug 2002 15:21:21 -0400
Message-Id: <200208011913.g71JDVR10533@zeppo.NMSU.Edu>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Vassili Papavassiliou <pvs@NMSU.Edu>
To: linux-kernel@vger.kernel.org
cc: Vassili Papavassiliou <pvs@NMSU.Edu>
Subject: Re: USB and PCMCIA drop out simultaneously during heavy data transfers (2.4.18) 
In-Reply-To: Your message of "Wed, 24 Jul 2002 10:09:38 +0200."
             <200207241009.38517.roger.larsson@skelleftea.mail.telia.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Thu, 01 Aug 2002 13:13:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| 
| Your logs shows several
| "Jul 18 14:58:33 localhost kernel: wvlan_cs: This is a PrismII card, not a 
| Wavelan IEEE card :-( "
| 
| ...
| 
| I do also use USB, memory card with quite big transfers. And I have never seen 
| this problem - I will look for it...
| 
| /RogerL
| 

Thank you for taking the time to respond. I showed the error logs for this 
card and driver as an example; however I see the same problem (simultaneous 
disconnects) using a 3Com 589D Ethernet card, an Adaptec 1480A SCSI adapter 
and even a PCMCIA modem (Gateway). All work fine until I move a USB mouse 
while a lot of data flows through the PCMCIA card (small transfers do not 
automatically hang the two). I don't have other USB devices with me at the 
moment to try, but I believe I have seen the effect in the past with others.

I'd be happy to attach more logs if someone wants to poke, and also to try 
suggestions for different settings etc. Thanks again,

                                                               Vassili

-- 
Vassili Papavassiliou             E-mail: pvs@nmsu.edu
NMSU, Physics Dept.               Phone: (505) 646-1310
Las Cruces, NM 88003              Fax:   (505) 646-1934


