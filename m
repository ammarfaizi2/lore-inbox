Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270817AbTG0PA5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 11:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270818AbTG0PA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 11:00:57 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:42500 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S270817AbTG0PAz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 11:00:55 -0400
Date: Sun, 27 Jul 2003 17:08:18 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Ihar Philips Filipau <filia@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_EMBEDDED in vanilla
Message-ID: <20030727170818.A26615@electric-eye.fr.zoreil.com>
References: <dcQ9.7aj.35@gated-at.bofh.it> <dcQ9.7aj.31@gated-at.bofh.it> <dhFS.3R3.11@gated-at.bofh.it> <dSm7.4TZ.5@gated-at.bofh.it> <dTrN.5Te.7@gated-at.bofh.it> <3F23E2CA.7070107@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F23E2CA.7070107@softhome.net>; from filia@softhome.net on Sun, Jul 27, 2003 at 04:33:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ihar Philips Filipau <filia@softhome.net> :
[...]
>    And those patches were not mine.

Testing/submitting/improving/syncing needs some generous amount of
time. You can easily help the author (especially) when things don't
evolve.

[...]
>    [ I was playing only with network code - and I was concerned with 
> performance more, than with image size. And had no luck achiving 
> something. ]

Try harder :o)

[...]
>    I have grepped thru 2.6.0-test0 - but I can find only entries in 
> defconfigs - but no mentions in .h/.c files.

KConfig ?

[...]
>    And yes - this option doesn't work in 'make menuconfig'.

No kernel tree at hand to figure what "doesn't work" mean but:
ed .config<<EOD
/# CONFIG_EMBEDDED is not set
d
wq
EOD

make oldconfig

works like a charm here.

If something seems wrong with 'make menuconfig', feel free to submit
a detailled PR here or through bugzilla.kernel.org (as long as it
isn't a networking thing).

[...]
> and more than 500 additional CONFIG_* parameters comparing to vanilla.

Provided the vendor can afford an army of kernel hackers to maintain
it, it is fine.

No need to Cc: me, I am subscribed to l-k.

--
Ueimor
