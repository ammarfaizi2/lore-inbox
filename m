Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290706AbSAROig>; Fri, 18 Jan 2002 09:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290707AbSAROiR>; Fri, 18 Jan 2002 09:38:17 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:1857 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S290706AbSAROiJ>; Fri, 18 Jan 2002 09:38:09 -0500
Message-ID: <3C48325A.EFFA4237@m3its.de>
Date: Fri, 18 Jan 2002 15:34:02 +0100
From: Klaus Meyer <k.meyer@m3its.de>
Organization: m3ITS
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: highmem=system killer, 2.2.17=performance killer ?
In-Reply-To: <Pine.LNX.3.96.1020117235335.5060B-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> On Fri, 18 Jan 2002, Klaus Meyer wrote:
> 
> > It was just a bad memory modul. Believe me, i'd tested them before
> > carefully.
> > But i had to learn that even ECC-modules installed in brand motherboards
> > dont tell you that they are not working correctly.
> 
> I wonder if your BIOS is doing the right thing setting the ECC config?
> That should have been reported.
> 

Yes you are right. That _should_ have been reported.
I'm using the ASUS CUR-DLS with the ServerSet LE III chipset.
I was honestly convinced that such a motherboard is constructed for
server usage and stability. Perhaps there is something wrong with my
board.
Since you have to use ECC modules in this motherboard there is
no way to configure a special ECC config mode in the bios.

The bad module (1 GB) was installed in bank 1 beside another GB module
in bank 0.
The board reported 2GB of installed ram.
I put it then in bank 0 as the only module installed.
The bios then reported 16M as mem, which is wrong of course, but: no
error.
It's really funny since all memory tests with 16M were sucessful (using
memtest).
After that the board always reported 16M not depending on the bank
position _without any error_.

I really don't know wether I should laugh or cry about that ;)
All in all the system is now working stable with other modules (2x1GB)
installed.

regards
	Klaus
