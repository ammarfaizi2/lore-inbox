Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbTHaMoH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 08:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbTHaMoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 08:44:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:48080 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261364AbTHaMoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 08:44:00 -0400
From: Hans-Peter Jansen <hpj@urpla.net>
To: Nick Urbanik <nicku@vtc.edu.hk>
Subject: Re: Single P4, many IDE PCI cards == trouble??
Date: Sun, 31 Aug 2003 14:43:55 +0200
User-Agent: KMail/1.5.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3F4EA30C.CEA49F2F@vtc.edu.hk> <1062150643.26753.4.camel@dhcp23.swansea.linux.org.uk> <3F4F5C9A.5BAA1542@vtc.edu.hk>
In-Reply-To: <3F4F5C9A.5BAA1542@vtc.edu.hk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308311443.55543.hpj@urpla.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Friday 29 August 2003 16:00, Nick Urbanik wrote:
>
> Performance is a relatively minor issue compared with stability and
> low cost.
>
> Is there _anyone_ who is using a number of ATA133 IDE disks (>=6),
> each on its own IDE channel, on a number of PCI IDE cards, and
> doing so successfully and reliably?  I begin to suspect not!  If
> so, please tell us what motherboard, IDE cards you are using.  I
> used to imagine that a terabyte of RAID storage on one P4 machine
> with ordinary cheap IDE cards with software RAID would be feasible.
>  I believe it is not (although I cannot afford to play musical
> motherboards).

It is. I'm running several pretty stable systems with IDE SW RAID 5
on top of Promise TX2/100 (~30 Eur) controllers. There was a long
standing limit of two cards from this type, which seems to be removed
lately (as Alan stated). At least, the test system hasn't fallen on 
it's face, when adding a third controller, and attached devices acted
as expected without freezing, throwing DMA errors, and the like.

Of course, the usual "don't buy the latest and greatest hardware, 
if the manufacturer isn't fully commited to linux support" applies.
Promise isn't!

Pete
