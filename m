Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133018AbRADNYK>; Thu, 4 Jan 2001 08:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133028AbRADNYB>; Thu, 4 Jan 2001 08:24:01 -0500
Received: from gidayu.max.uni-duisburg.de ([134.91.242.4]:6672 "HELO
	gidayu.max.uni-duisburg.de") by vger.kernel.org with SMTP
	id <S133018AbRADNXp>; Thu, 4 Jan 2001 08:23:45 -0500
Date: Thu, 4 Jan 2001 14:23:35 +0100
From: Christian Loth <chris@gidayu.max.uni-duisburg.de>
To: "Ingo T. Storm" <it@computerbild.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DHCP Problems with 3com 3c905C Tornado
Message-ID: <20010104142335.E15097@gidayu.max.uni-duisburg.de>
In-Reply-To: <012101c0764f$c8b2f840$7400a8c0@dukat.cb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <012101c0764f$c8b2f840$7400a8c0@dukat.cb.de>; from it@computerbild.de on Thu, Jan 04, 2001 at 02:11:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

On Thu, Jan 04, 2001 at 02:11:00PM +0100, Ingo T. Storm wrote:
> 
> Have you checked conf.modules that now is modules.conf?
> 

Yes I have. By editing it, I was able to test both the 3c59x 
and the 3c90x drivers. Also the modules were correctly loaded
in both testruns, which I confirmed with a lsmod.

On another note: I *was* able to set up the card manually
by doing an ifconfig (and it worked that way), but as the
firewall adapts dynamically to the DHCP leases, this
is not a solution. So only DHCP negotiation was not working,
which worked OK with the vanilla RH 6.2 2.2.14 kernel.

- Chris

-- 
Christian Loth
Coder of 'Project Gidayu'
Computer Science Student, University of Dortmund
chris@gidayu.mud.de - http://gidayu.mud.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
