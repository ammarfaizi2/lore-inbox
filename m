Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbULCSXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbULCSXp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 13:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbULCSXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 13:23:44 -0500
Received: from mail.linicks.net ([217.204.244.146]:49413 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261544AbULCSXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 13:23:42 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: newbie kernel hacking question.
Date: Fri, 3 Dec 2004 18:23:41 +0000
User-Agent: KMail/1.7
References: <200412031715.15067.nick@linicks.net> <1102096955.14037.5.camel@mcmanus.datapower.com>
In-Reply-To: <1102096955.14037.5.camel@mcmanus.datapower.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412031823.41165.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 December 2004 18:02, patrick mcmanus wrote:
> maybe a helpful hint:
>
> "lilo -R newimage" will let you boot a new kernel for just the next boot
> without changing your default.. that way if it hangs/crashes you can
> just punch the reset button and it will reboot into the old working
> version..

Excellent, excellent tip.  So much good stuff here.

But it all worked anyway!  My first hack :D

uname -r 2.4.28
Nov 24 13:29:44 quake kernel: Floppy drive(s): fd0 is 1.44M
Nov 24 13:29:44 quake kernel: keyboard: Timeout - AT keyboard not present?(ed) 
Nov 24 13:29:44 quake kernel: keyboard: Timeout - AT keyboard not present?
(f4)
Nov 24 13:29:44 quake kernel: FDC 0 is a National Semiconductor PC87306
Nov 24 13:29:44 quake kernel: loop: loaded (max 8 devices)

uname -r 2.4.28.nokb
Dec  3 18:08:47 quake kernel: Floppy drive(s): fd0 is 1.44M
Dec  3 18:08:47 quake kernel: FDC 0 is a National Semiconductor PC87306
Dec  3 18:08:47 quake kernel: loop: loaded (max 8 devices)

Seemd to boot faster too, but reading the code I can't see why - maybe I am 
all excited ;)

Many thanks,

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
