Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbRGHXiv>; Sun, 8 Jul 2001 19:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266981AbRGHXib>; Sun, 8 Jul 2001 19:38:31 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.121.50]:25281 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S266983AbRGHXiT>; Sun, 8 Jul 2001 19:38:19 -0400
Message-ID: <3B48EF12.9020504@earthlink.net>
Date: Sun, 08 Jul 2001 16:38:58 -0700
From: SubSolar <subsolar@earthlink.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010708
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: natsemi trouble with netgear fa311 in 2.4.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a NetGear FA311 pci card that uses the natsemi.c driver and have 
had no
problems with it in all kernels 2.4.0 through 2.4.5.  However with 2.4.6 
(also
tried 2.4.6-ac2) I am getting strange behavior.  As soon as an ip is 
given to it
(with either dhcp or manual ip) this error message keeps repeating:

eth0:  Something Wicked happened! 18000

and I can't ping anything else except itself.  It's always 18000.  I've 
tried
switching the card to another pci slot, checked the cables, etc.  When I 
switch back
to kernel 2.4.5 everything works perfectly.

The bootup message is:  eth0: Setting full-duplex based on negotiated link
capability.
And lspci shows:  Ethernet controller: National Semiconductor 
Corporation: Unknown
device 0020

The computer is a k6-2 400 with an ASUS P5A motherboard (ALi chipset)

