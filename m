Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271717AbRH0Lv5>; Mon, 27 Aug 2001 07:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271715AbRH0Lvr>; Mon, 27 Aug 2001 07:51:47 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:28946 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S271717AbRH0Lve>; Mon, 27 Aug 2001 07:51:34 -0400
Date: Mon, 27 Aug 2001 13:51:50 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.8-ac12
Message-ID: <20010827135150.C17318@maggie.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010827093529.A31359@emma1.> <E15bK7s-0003iU-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15bK7s-0003iU-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Aug 27, 2001 at 12:00:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2001, Alan Cox wrote:

> That sounds like your bridge cards lack enough buffering or can't cope with
> back to back frames. This bites people who use 8K buffer ISA cards in 
> paticular.

Well, 3C905TX-M here, should be pretty ok, but the NFS failure might
related to the bridge-netfilter-patches. Looks I'd better set up that
box as router rather than a bridge (and just keep a boot floppy that
makes it a bridge around should the disks fail).

> -ac12 should be pretty solid. Im about to put out 2.4.9-ac1 which is 
> more experimental, although it has run all night, something 2.4.9 never 
> managed

2.4.9: up 2 days, 17:55,  1 user,  load average: 0.22, 0.15, 0.06

That box is a lightly loaded SMTP/IMAP/WWW server, no X11R6, user logins
if at all via ssh.

I'll see if 2.4.8-ac12 works for me.

-- 
Matthias Andree
