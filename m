Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290388AbSAPJKQ>; Wed, 16 Jan 2002 04:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290384AbSAPJKG>; Wed, 16 Jan 2002 04:10:06 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:43662 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289891AbSAPJJs>; Wed, 16 Jan 2002 04:09:48 -0500
Message-Id: <200201151920.g0FJK09j002000@tigger.cs.uni-dortmund.de>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away? 
In-Reply-To: Message from "Eric S. Raymond" <esr@thyrsus.com> 
   of "Mon, 14 Jan 2002 15:17:48 EST." <20020114151748.B19776@thyrsus.com> 
Date: Tue, 15 Jan 2002 20:20:00 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> said:

[...]

> Actually I think we may no longer be in tristate-land.  Instead, some
> devices have the property "This belongs in initramfs if it's configured
> at all" -- specifically, drivers for potential boot devices.  Everything
> else can dynamic-load after boot time.  

Then all SCSI drivers end up in the initramfs for the install kernel for
a distro? There might be _many_ devices configured that don't need to
reside on the initramfs.

OTOH, the initramfs will get built and populated by separate tools (just
like initrd is done today), so the alternatives would boil down to M/N.
_If_ the grand scheme of getting rid of builtins flies. I for one wouldn't
hold my breath.
-- 
Horst von Brand			     http://counter.li.org # 22616
