Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLWUEJ>; Sat, 23 Dec 2000 15:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129410AbQLWUD7>; Sat, 23 Dec 2000 15:03:59 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:60805 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S129260AbQLWUDl>;
	Sat, 23 Dec 2000 15:03:41 -0500
Message-ID: <3A44FDF9.B7EBC91E@pobox.com>
Date: Sat, 23 Dec 2000 11:33:13 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting Group
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10-ll i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Hayden A. James" <hjames@quantumcode.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with tdfx drm module
In-Reply-To: <20001223191906.F317682C@photon.quantumcode.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hayden A. James" wrote:

> [root@neutron /root]# modprobe tdfx
> /lib/modules/2.4.0-test13pre4-ac2/kernel/drivers/char/drm/tdfx.o:
> unresolved symbol remap_page_range
> /lib/modules/2.4.0-test13pre4-ac2/kernel/drivers/char/drm/tdfx.o:
> unresolved symbol __wake_up
> /lib/modules/2.4.0-test13pre4-ac2/kernel/drivers/char/drm/tdfx.o:

<snip>

Same problem here - last good kernel for drm was -test12

My olympic.o token ring driver at work is similarly affected

It just needs sorting out the makefile changes, hopefully soon.

jjs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
