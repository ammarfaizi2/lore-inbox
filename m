Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVCEVIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVCEVIt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 16:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVCEVIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 16:08:49 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:9925 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261169AbVCEVIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 16:08:43 -0500
Message-ID: <422A1FB6.3000504@ens-lyon.org>
Date: Sat, 05 Mar 2005 22:08:06 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>, seife@suse.de,
       Len Brown <len.brown@intel.com>
Subject: Re: s4bios: does anyone use it?
References: <20050305191405.GA1463@elf.ucw.cz>
In-Reply-To: <20050305191405.GA1463@elf.ucw.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek a écrit :
> Hi!
> 
> Is there single user of s4bios? It used to work for me 4 notebooks
> ago, but I never really used it. I think I'm the only person that ever
> seen it working, but I could be wrong. Is there anyone using s4bios in
> 2.6.11?
> 
> If not, I guess we should remove that code from kernel. It is not
> usefull, and it is likely broken.
> 								Pavel

Hi Pavel,

I always suspend my Compaq Evo N6OOc to disk using "echo 4b > /proc/acpi/sleep".
I don't remember the reason why I originally did choose this one instead of S4.
I just checked that S4 and S4Bios work the same on 2.6.11-mm1 (even with my
PCMCIA wireless card connected, great!).
 From what I remember, I didn't see any difference between S4 and S4Bios in
recent vanilla kernels.

By the way, it seems that Radeon makes suspend slower because it needs
to be blanked or something like that. Is there any way to avoid this ?

Regards

Brice
