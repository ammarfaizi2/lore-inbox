Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263390AbUJ2O5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263390AbUJ2O5i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbUJ2OxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:53:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27667 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263386AbUJ2Ovr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:51:47 -0400
Date: Fri, 29 Oct 2004 16:51:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       "H. Peter Anvin" <hpa@zytor.com>, Tonnerre <tonnerre@thundrix.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, uclibc@uclibc.org
Subject: Re: The naming wars continue...
Message-ID: <20041029145111.GO6677@stusta.de>
References: <200410271133.25701.vda@port.imtp.ilyichevsk.odessa.ua> <417FF43C.5050208@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417FF43C.5050208@tmr.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 03:17:16PM -0400, Bill Davidsen wrote:
> Denis Vlasenko wrote:
> >
> >Why there is any distinction between, say, gcc and X?
> >KDE and Midnight Commander? etc... Why some of them go
> >to /opt while others are spread across dozen of dirs?
> >This seems to be inconsistent to me.
> 
> At one time Sun had the convention that things in /usr could be mounted 
> ro on multiple machines. That worked, it predates Linux so Linux was the 
> o/s which chose to go another way, and it covered the base things in a 
> system.
> 
> That actually seems like a good way to split a networked environment, 
> with /bin and /sbin having just enough to get the system up and mount 
> /usr. I can't speak to why that is being done differently now.
> 
> I guess someone was nervous about mounting a local /usr/local on a 
> (possibly) network mounted /usr and theu /opt, but that's a guess on my 
> part as well.

Read-only /usr is required according to the FHS, and at least on Debian 
a read-only /usr works without problems.

A bigger problem might be to properly support it in the package manager.

cu
Adrian

[1] 

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

