Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264958AbRGSQXE>; Thu, 19 Jul 2001 12:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264927AbRGSQWz>; Thu, 19 Jul 2001 12:22:55 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:55559
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S264624AbRGSQWm>; Thu, 19 Jul 2001 12:22:42 -0400
Date: Thu, 19 Jul 2001 12:32:22 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Ryan Sweet <rsweet@atos-group.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.6 and netboot
Message-ID: <20010719123222.B556@animx.eu.org>
In-Reply-To: <20010719082650.A26980@animx.eu.org> <Pine.SGI.4.10.10107191618070.3370909-100000@iapp-0>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.SGI.4.10.10107191618070.3370909-100000@iapp-0>; from Ryan Sweet on Thu, Jul 19, 2001 at 04:51:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> > I'm using a kernel that is dd'd to a floppy to net boot linux on random
> > machines.  I noticed that 2.4.6 won't get it's IP from the server (it won't
> > even attempt it).  2.4.4 works
> > 
> > If any more info is needed, just ask.
> 
> It sounds as though you left out CONFIG_IP_PNP in the kernel
> configuration.  netboot works fine under 2.4.6 for me....

# grep CONFIG_IP_PNP /usr/src/linux/wdist/2.4.6/.config       
CONFIG_IP_PNP=y
# CONFIG_IP_PNP_DHCP is not set
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
#

Nope, didn't.  2.4.4 works just fine, 2.4.6 doesn't.  I also have no way of
doing kernel parameters since it's a raw kernel.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
