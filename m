Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261418AbSIXP4I>; Tue, 24 Sep 2002 11:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261691AbSIXP4I>; Tue, 24 Sep 2002 11:56:08 -0400
Received: from smtp03.web.de ([217.72.192.158]:50724 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S261418AbSIXP4H> convert rfc822-to-8bit;
	Tue, 24 Sep 2002 11:56:07 -0400
From: "Todor Todorov" <ttodorov@web.de>
To: "'Feldman, Scott'" <scott.feldman@intel.com>,
       <linux-kernel@vger.kernel.org>
Subject: AW: eepro100/e100 drivers fragment heavily
Date: Tue, 24 Sep 2002 18:06:20 +0200
Message-ID: <15CB59420A67D511878F0090279C2C9B01ACF1@SKRSERVERHB>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <288F9BF66CD9D5118DF400508B68C446047589DF@orsmsx113.jf.intel.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I can confirm that the nic is set to auto-sensing/auto-negotiation.
There is no way for me to change the behaviour of the switch, it's
always auto-negotiation. Also, I cannot say to what state a port on the
switch is set at one time - if it is half- or full-duplex etc.

But it would seem that I have some sort of hardware problem, my guess
would be the motherboard. Some problems with my cd/dvd drive occurred,
besides this the I installed win xp on the same machine as dual boot to
check it out and the network behaviour is exactly the same. Sorry, it
seems to be false alarm.

Cheers,
Todor

-----Ursprüngliche Nachricht-----
Von: Feldman, Scott [mailto:scott.feldman@intel.com] 
Gesendet: Montag, 23. September 2002 22:04
An: 'Todor Todorov'; linux-kernel@vger.kernel.org
Betreff: RE: eepro100/e100 drivers fragment heavily

Todor Todorov wrote:

> The computer is a 
> Dell Inspiron 8000 laptop with an internal Actiontec 
> modem/nic combo pci card based on the Intel Pro chip, running 
> Debian. I observed this behaviour with the eepro100 drivers 
> in 2.4.19, 2.4.20-pre6 and 2.4.20-pre7 and e100 drivers in 
> 2.4.20-pre6 and -pre7. Pulling data from the network is fine 
> and fast though, only sending is a problem. The only hint I 
> have of what migh be causing the problem is something I read 
> in the specs of my NWAY SOHO switch - it would allow 
> full-duplex 100 MBit/sec only based on auto negotiation, if a 
> nic is in forced mode (say 100 MBit full-duplex), the swith 
> will allow only 100 MBit half-duplex. I tried other high 
> quality switches too, but the result was the same. 

Please confirm that the switch and nic are both set to auto-neg, or both
the
switch and the nic forced to the same settings (i.e. 100/half).  We need
to
make sure both ends of the wire match.

-scott



