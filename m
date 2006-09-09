Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWIIOpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWIIOpk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 10:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWIIOpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 10:45:04 -0400
Received: from smtp111.iad.emailsrvr.com ([207.97.245.111]:64654 "EHLO
	smtp141.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S932233AbWIIOpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 10:45:01 -0400
Message-ID: <4502D35E.8020802@gentoo.org>
Date: Sat, 09 Sep 2006 10:44:46 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060818)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, torvalds@osdl.org, sergio@sergiomb.no-ip.org,
       jeff@garzik.org, greg@kroah.com, cw@f00f.org, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru, liste@jordet.net
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
References: <20060907223313.1770B7B40A0@zog.reactivated.net> <1157811641.6877.5.camel@localhost.localdomain>
In-Reply-To: <1157811641.6877.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Very large numbers of VIA mainboards ship with some of the VIA devices
> built in and some of them on the PCI bus. 

What's the difference between "built in" and "on the PCI bus"? Both 
types are physically a part of the mainboard, and need to be quirked, right?

The corner case I was referring to is where someone plugs an *external* 
VIA-based PCI card into a PCI slot on a VIA motherboard. In that case, 
the PCI card gets quirked too, when it didn't need to be, and this may 
or may not cause problems...

> You know from the northbridge which devices are internal and which are
> external.

I don't know much about PCI. How can I detect this?

Alternatively if you (or anyone else who knows PCI) wants to write a new 
patch or modify the existing one I would have no objections. I can also 
get a few people to test it.

Thanks.
Daniel
