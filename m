Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262843AbRE3WGJ>; Wed, 30 May 2001 18:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262845AbRE3WF7>; Wed, 30 May 2001 18:05:59 -0400
Received: from ns.caldera.de ([212.34.180.1]:52717 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S262843AbRE3WFs>;
	Wed, 30 May 2001 18:05:48 -0400
Date: Thu, 31 May 2001 00:05:05 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcus Meissner <Marcus.Meissner@caldera.de>,
        Marcus Meissner <mm@ns.caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: ln -s broken on 2.4.5
Message-ID: <20010531000505.A30497@caldera.de>
In-Reply-To: <20010530233005.A27497@caldera.de> <E155DqA-0006g7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E155DqA-0006g7-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, May 30, 2001 at 10:49:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 10:49:18PM +0100, Alan Cox wrote:
> > The problem is only there if you specify a directory for the linked to
> > component.
> > 
> > [marcus@wine /tmp]$ strace -f ln -s fupp/berk xxx
> > execve("/bin/ln", ["ln", "-s", "fupp/berk", "xxx"], [/* 39 vars */]) = 0
> > ... ld stuff ... locale stuff ... 
> 
> bash-2.04$ ln -s foo/frob eep
> bash-2.04$ ls -l eep
> lrwxrwxrwx    1 alan     users           8 May 30 22:19 eep -> foo/frob

*sigh*

I just rebooted and it is no longer reproducable.

Sorry for the confusion caused.

Ciao, Marcus
