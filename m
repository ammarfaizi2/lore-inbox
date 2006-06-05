Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750815AbWFEPz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWFEPz4 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 11:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWFEPz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 11:55:56 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:64966 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750815AbWFEPzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 11:55:55 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: 2.6.17-rc5-mm3: "BUG: scheduling while atomic" flood when resuming from disk
Date: Mon, 5 Jun 2006 17:56:19 +0200
User-Agent: KMail/1.9.3
Cc: "Andrew Morton" <akpm@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
        "Arjan van de Ven" <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <986ed62e0606042223l2381d877g4bc798ec64804d43@mail.gmail.com>
In-Reply-To: <986ed62e0606042223l2381d877g4bc798ec64804d43@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606051756.19715.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 June 2006 07:23, Barry K. Nathan wrote:
> Quoting myself from another recent e-mail:
> 
> > BTW, I also tried 2.6.17-rc5-mm3 (with no other patches) on another
> > box of mine, running Ubuntu Dapper Drake. (It was installed with one
> > of the flights but has been updated to the final release.) It got hit
> > with a flood of scheduling-while-atomic BUGs when either suspending to
> > disk or resuming, and eth0 didn't come back up automatically as usual
> > -- I had to manually modprobe r8169 and then run
> > "/etc/init.d/networking restart" to get to the outside world again. I
> > might not be able to provide a more detailed report on this box for
> > another day or two.
> 
> The messages definitely happen while resuming. My screen is blank
> during suspend-to-disk so I have no way to know what's going on
> then...

Please try doing "echo 8 > /proc/sys/kernel/printk" before suspend.

Greetings,
Rafael
