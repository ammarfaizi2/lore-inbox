Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280448AbRJaTs3>; Wed, 31 Oct 2001 14:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280447AbRJaTsT>; Wed, 31 Oct 2001 14:48:19 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:46980 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S280443AbRJaTsJ>;
	Wed, 31 Oct 2001 14:48:09 -0500
Message-ID: <3BE0559D.573B9907@pobox.com>
Date: Wed, 31 Oct 2001 11:48:45 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Daniel R. Warner" <drwarner@mail.myrealbox.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6 + preempt dri lockup
In-Reply-To: <20011031152822Z280263-17408+8294@vger.kernel.org> <3BE04DE8.F012C592@pobox.com> <3BE050A6.90404@mail.myrealbox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Daniel R. Warner" wrote:

> I experience random lockups and crashes in UT and Q3.
> (not particularly concerned about it though)
> I have not experienced any problems with this box outside of DRI.

I have to say, I can't remember ever seeing
a lockup in q3 with this system - DRI has been
very well behaved.

Now, sometimes a 3d xscreensaver module
will freeze and lock the console, but if I log in
from a serial port or from the net, I can kill the
module and the console is freed up again.

With the wolfenstein demo, there are some long
hangs, but it appears to be strictly an application
issue - if I press escape repeatedly, it usually
recovers. If it doesn't recover, I can always
run "[ALT][SYSRQ] k" and get back to the gdm
login screen.

There have been some buggy test kernels that
collapsed of their own accord, but I must say,
no app has ever taken the system down with
a production kernel, nor with any linus kernel
newer than 2.4.10 on this UP system.

To recap:
------------

PIII-933 on intel mobo
512 MB RAM
2x30 GB maxtor ide
Voodoo 3 2000 AGP

Red Hat 7.1 + XFree 4.1.0-3 from rawhide
kernel 2.4.14-pre6+preempt-2.4.14-pre5-1+2.4.13-low-latency.patch




