Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318047AbSHGLNX>; Wed, 7 Aug 2002 07:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318035AbSHGLNX>; Wed, 7 Aug 2002 07:13:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:43909 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317980AbSHGLNW>; Wed, 7 Aug 2002 07:13:22 -0400
Date: Wed, 7 Aug 2002 07:18:17 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dax Kelson <dax@gurulabs.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ethtool documentation
In-Reply-To: <Pine.LNX.4.44.0208062318350.4696-100000@mooru.gurulabs.com>
Message-ID: <Pine.LNX.3.95.1020807070841.28061A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002, Dax Kelson wrote:

> On Tue, 6 Aug 2002, Richard B. Johnson wrote:
> 
> > If you let a user write to this area, you will allow the user
> > to destroy the connectivity on a LAN.
> > 
> > Because of this, there is no such thing as 'unused eeprom space' in
> > the Ethernet Controllers. Be careful about putting this weapon in
> > the hands of the 'public'. All you need is for one Linux Machine
> > on a LAN to end up with the same IEEE Station Address as another
> > on that LAN and connectivity to everything on that segment will
> > stop. You do this once at an important site and Linux will get a
> > very black eye.
> 
> Dick, this "weapon" has been the in the hands of admins and evil-doers for 
> YEARS!
> 
> It is called /sbin/ifconfig
> 
> With this evil command nearly any NIC can masquerade as any one of
> ~281474976710656 possible IEEE Station Addresses. This weapon of
> destruction has seen wide spread proliferation across most Unix varients.
> Human sacrifice, dogs and cats living together, mass hysteria!
> 
> Err, no wait.
> 
> The sky is not falling, you protest too much.
> 
> Dax Kelson
> 

That capability is not permanent. If you let users write to the
SEEPROM, permanently changing the IEEE Station Address, you have
let users permanently break their network boards. I do protest
when this capability is in the kernel.

Anybody, who knows how can, write a driver that can destroy their
disk drives, their modems, their audio boards, their screen-cards,
their motherboards, ...the list goes on..., because EEPROMS are
being used now days. But, you don't put that capability in the
kernel as a default.

If you do, you get complaints from those who have had the misfortune of
being interrogated by lawyers.

Also, if you want to destroy Ethernet, mucking with the MAC address
is an easy way to do it.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

