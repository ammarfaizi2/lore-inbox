Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291241AbSAaTSA>; Thu, 31 Jan 2002 14:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291242AbSAaTRv>; Thu, 31 Jan 2002 14:17:51 -0500
Received: from flubber.jvb.tudelft.nl ([130.161.76.47]:3206 "EHLO
	mail.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S291241AbSAaTRe>; Thu, 31 Jan 2002 14:17:34 -0500
From: "Robbert Kouprie" <robbert@jvb.tudelft.nl>
To: "'Ben Greear'" <greearb@candelatech.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)
Date: Thu, 31 Jan 2002 20:17:21 +0100
Message-ID: <000f01c1aa8b$e7fbcee0$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <3C5984C9.20104@candelatech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I experienced the 10 Mbit half duplex problems too with this card, but
they seemed to have gone away after a bugfix from Alan Cox somewhere in
2.4. Somewhere later I upgraded to 100 Mbit full duplex and never
experienced problems again until 2.4.17.

I think im gonna try some older kernels and look through diffs if I have
time.

- Robbert

> -----Original Message-----
> From: Ben Greear [mailto:greearb@candelatech.com] 
> Sent: donderdag 31 januari 2002 18:54
> To: Robbert Kouprie
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)
> 
> 
> 
> 
> Robbert Kouprie wrote:
> 
> > The box is an Abit BP6 with Dual Celerons 433 and 192 Mb RAM. No
> > PCI-Riser cards. It is connected at 100 Mbit full duplex to a 100
> > Mbit switch. APIC is enabled. No kind of power management 
> is enabled.
> 
> 
> The only lockup problems I have run into are connecting some 
> eepro nics to
> a 10bt hub, and using (cheap arsed, it appears) PCI riser 
> cards.  I have
> heard of some SMP related issues, but nothing concrete, and I don't
> have any SMP systems personally.  You could try the e100, but I have
> no idea if it will be better or worse for your particular problem.
> 
> 
> -- 
> Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
> President of Candela Technologies Inc      http://www.candelatech.com
> ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
> 
> 

