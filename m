Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUKBRrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUKBRrp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 12:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbUKBRpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 12:45:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14857 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261284AbUKBReL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 12:34:11 -0500
Date: Tue, 2 Nov 2004 18:33:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christian <evil@g-house.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 5 compile errors for 2.4-BK
Message-ID: <20041102173337.GG4978@stusta.de>
References: <41879488.10601@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41879488.10601@g-house.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 03:07:04PM +0100, Christian wrote:

> every day my scripts compile several kernel from the latest -BK tree,
> since oct, 30. there are 5 compile errors shown in:
> 
> make[3]: [neighbour.o] Error 1 (ignored)
> make[3]: [core.o] Error 1 (ignored)
> make[3]: [arp.o] Error 1 (ignored)
> make[3]: [ipv4.o] Error 1 (ignored)
> make[1]: [first_rule] Error 2 (ignored)
> 
> [and that's why these 2 occur too:]
> 
> make: [vmlinux] Error 1 (ignored)
> make: [zImage] Error 2 (ignored)

This part of the errors alone is useless.

> full make logs, configs here:
>...
> this is all with debian/unstable, using gcc-3.4.2, binutils-2.15 (both
>...

Did you manually change your gcc link or are you using gcc 3.3 ?

> maybe someone may find this useful...

Other people already do similar things.

The interesting thing is the exact error message. Your 5 errors are 
actually only two (similar) compile errors.

For being really useful, a posting of the error messages of the two 
actual error messages would be useful. If you trace down who is "guilty" 
for the compile error and Cc the person in question it's even better 
(but please check linux-kernel before being the tenth person reporting 
the same issue).

> thanks,
> Christian.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


