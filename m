Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267226AbUBMVYu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267229AbUBMVYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:24:50 -0500
Received: from [80.72.36.106] ([80.72.36.106]:34989 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S267226AbUBMVYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:24:46 -0500
Date: Fri, 13 Feb 2004 22:24:40 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Daniel Drake <dan@reactivated.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is nForce2 good choice under Linux?
In-Reply-To: <402D3448.7080105@reactivated.net>
Message-ID: <Pine.LNX.4.58.0402132205510.31906@alpha.polcom.net>
References: <Pine.LNX.4.58.0402132048330.31906@alpha.polcom.net>
 <402D3448.7080105@reactivated.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your fast response!

> I haven't tried the SATA or firewire capabilities of my board, but I believe 
> both work. Everything else (sound, network, ...) works OK.

Is anybody using these features? I am thinking about connecting two 120GB 
WD SATA drives (raid) to improve performance and seek times. But I have to 
know if SATA controller works under Linux... (i think it is Silicon Image 
controller or something like that...) Is TCQ supported on these 
controllers? Or it depends on disks being used?


> Apparently, nvidia are working on new (binary) drivers for nforce-audio which 
> will do hardware mixing and the likes.

Hope it will work with ALSA...


> Yes, there is a problem. This is a hardware problem, which can likely be fixed 
> in a BIOS update. Those who have tried contacting manufacturers have basically 
> failed.
> There is a bug relating to the C1 disconnect feature of AMD CPU's. It causes a 
> total system freeze. There is some quite detailed info on this in recent 
> threads, search the archive if you are interested.
>
> For the majority of people (as I understand it), these lockups can be totally 
> avoided by *not* using APIC/IOAPIC. I never met a lockup until I enabled APIC 
> for the first time. The older XTPIC paths are generally not fast enough to 
> trigger the C1 bug. Ross Dickson has done some great work here, and he has 
> produced patches which workaround this particular bug. His last two revisions 
> of patches have worked great for me (and others), not a lockup since.

You mean that kernel 2.6-mm with this patch with APIC and ACPI enabled 
works OK? Is this patch a complete fix or a workaround?

Btw. Is CPU frequency scaling supported on this board (with ACPI)? What 
about other power saving technologies?


> I have been perfectly happy with my NF7-S, except from the one time it failed 
> on me (didn't boot up), and I had to get it replaced. I think there is a 
> general risk involved in buying nforce2 boards, their rate of failure is 
> fairly high. Still, the benefits are nice.

Wow! This fringtens me! What do you mean? Why are they so failure-able? 
Are they worse than other new boards in it? Are they, at least, easily, 
fast and free replaced (under warranty)?


Thanks again!


Grzegorz Kulewski

