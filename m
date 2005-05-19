Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVESPP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVESPP4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 11:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVESPNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 11:13:31 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:60086 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S262540AbVESO7V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 10:59:21 -0400
Message-ID: <428CA9BE.8010107@ens-lyon.org>
Date: Thu, 19 May 2005 16:59:10 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm2
References: <20050516021302.13bd285a.akpm@osdl.org>
In-Reply-To: <20050516021302.13bd285a.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm2/
> 
> 
> - davem has set up a mm-commits mailing list so people can review things
>   which are added to or removed from the -mm tree.  Do
> 
> 	echo subscribe mm-commits | mail majordomo@vger.kernel.org
> 
> - x86_64 architecture update from Andi.
> 
> - Everything up to and including `spurious-interrupt-fix.patch' is planned
>   for 2.6.12 merging.  Plus a few other things in there.
> 
> - Another DVB subsystem update

Hi Andrew and Dominik,

Since mm2, udev cannot rename my pcmcia wireless interface.
rc4 and rc4-mm1 successfully rename it from eth0 to wifi.
rc4-mm2 only renames the internal interface, not the pcmcia wifi one.

When I insert the card, This line appears in syslog:
udev[9500]: configured rule in '/etc/udev/rules.d/brice.rules[4]'
applied, 'eth0' becomes 'wifi'
But the interface is still called eth0.

Any idea ?

Thanks,
Brice

PS: Richard Purdie's patch (http://lkml.org/lkml/2005/5/18/303) fixed my
previous cardctl breakage, but it doesn't change anything regarding this
bug.
