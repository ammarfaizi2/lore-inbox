Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBHPKA>; Thu, 8 Feb 2001 10:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130201AbRBHPJu>; Thu, 8 Feb 2001 10:09:50 -0500
Received: from smtp1.free.fr ([212.27.32.5]:58888 "EHLO smtp1.free.fr")
	by vger.kernel.org with ESMTP id <S129181AbRBHPJf>;
	Thu, 8 Feb 2001 10:09:35 -0500
To: linux-kernel@vger.kernel.org
Subject: Multiple PPP sessions w/o load balancing, possible ?
Message-ID: <981644973.3a82b6add1bb1@imp.free.fr>
Date: Thu, 08 Feb 2001 16:09:33 +0100 (MET)
From: Bastien Nocera <hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 194.237.142.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry if my question is out of the scope of lkml. If you know a better place for 
this, please tell me.

The problem is:
We (me and my work colleagues) need to setup some heavy testing of a 
telecom network. Right now, we are using a laptop and a mobile phone for each 
ppp session we want to setup.

The idea was that we could ease the setup of this test by using one laptop, 
running multiple ppp sessions, using 2 quad serial port pcmcia cards and 
starting up 9 ppp sessions (2x4 on the serial card + 1 mobo port) each one on 
one of the 9 phones.

My idea was to have one IP address to contact per interface and add the proper 
routing so that creating traffic to an IP address would automatically go to one 
interface. The problem is that we're not able to make any changes to the already 
in place servers.

So, to make a long story short, we need to simulate 9 laptops+mobile phones with 
1 laptop, 2 serial cards and 9 phones.
I'll repeat that to be sure. We know how to setup the cards, the ppp sessions, 
but not how to create traffic on one specific interface without using load 
balancing or multiple target IP addresses.

If anybody can help, I'll be grateful (and my boss as well =).

Cheers

/Bastien Nocera
http://hadess.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
