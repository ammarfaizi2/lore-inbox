Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292375AbSB0Pon>; Wed, 27 Feb 2002 10:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292581AbSB0PoW>; Wed, 27 Feb 2002 10:44:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32786 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292584AbSB0PoO>;
	Wed, 27 Feb 2002 10:44:14 -0500
Message-ID: <3C7CFECB.99684779@mandrakesoft.com>
Date: Wed, 27 Feb 2002 10:44:11 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [BETA-0.92] Third test release of Tigon3 driver
In-Reply-To: <20020227.055102.75257130.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> If people with real VLANs can try to get the HW acceleration stuff
> working, I'd really appreciate it.  Especially the person who (GASP)
> wanted us to put the tasteless NICE stuff into our driver. :-)
> 
> Adding support to the Acenic driver should be pretty easy and I'll
> try to do that before catching some sleep.  Jeff could also probably
> cook up something quick for the e1000.

I'll practice by adding to 8139cp driver first ;-)

e1000 has a VLAN filter type on-chip, which complicates things a tiny
bit.

I think dl2k gigabit driver has easy VLAN tagging, too.  I'll try to
take care of that one was well (before tackling e1000 <g>)

	Jeff



-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
