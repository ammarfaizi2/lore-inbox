Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315381AbSEBT2O>; Thu, 2 May 2002 15:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315379AbSEBT1Y>; Thu, 2 May 2002 15:27:24 -0400
Received: from zeus.kernel.org ([204.152.189.113]:39412 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S315381AbSEBT1G>;
	Thu, 2 May 2002 15:27:06 -0400
Date: Thu, 2 May 2002 08:48:16 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Stephen Samuel <samuel@bcgreen.com>, Bill Davidsen <davidsen@tmr.com>,
        Andre Hedrick <andre@linux-ide.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
Message-ID: <20020502154816.GV574@matchmail.com>
Mail-Followup-To: Xavier Bestel <xavier.bestel@free.fr>,
	Stephen Samuel <samuel@bcgreen.com>,
	Bill Davidsen <davidsen@tmr.com>,
	Andre Hedrick <andre@linux-ide.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10204260028140.10216-100000@master.linux-ide.org> <Pine.LNX.3.96.1020429173812.26335B-100000@gatekeeper.tmr.com> <20020502034530.GT574@matchmail.com> <3CD0F846.3070605@bcgreen.com> <1020329390.2595.9.camel@bip>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 10:49:50AM +0200, Xavier Bestel wrote:
> Le jeu 02/05/2002 ? 10:26, Stephen Samuel a ?crit :
> > I ran a similar type of test on a 2.4.9.31 (redhat 7.1 ) kernel.
> > With the CD on HDD, I could read off of HDA just peachy while
> > the system was choking on a scratched (aol) cd.
> 
> The "system grinding to a halt" happens to me too, when *ripping*
> scratched cds. Note that it's when using *userspace* access to the block
> device, with e.g. cdparanoia or grip (or dvd ripping tools).
> 
> My DVD drive is on a VT82C693A/694x (ABit VP6).

Ahh, that's a good distinction to make.  I'll be testing CD ripping on this
machine eventually too.

Are you burning CDs at the same time as ripping?  If so, try doing that in a
two step process and see where the problem occours.

Can you post the full output of lspci?  Be sure to mention what drives are
on which controller (if you have two or more).

Can you post the kernel output from dmesg when it detects your drives?

Do you have any ISA devices in this system?

Can you post the commands it takes to reproduce the condition?

Also, `vmstat 1` output while the system is unresponsive would be good too.

Thanks,

Mike
