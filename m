Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263198AbTCWUlG>; Sun, 23 Mar 2003 15:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263200AbTCWUlG>; Sun, 23 Mar 2003 15:41:06 -0500
Received: from franka.aracnet.com ([216.99.193.44]:30943 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263198AbTCWUlF>; Sun, 23 Mar 2003 15:41:05 -0500
Date: Sun, 23 Mar 2003 12:51:58 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
       Alan Cox <alan@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, Pavel Machek <pavel@ucw.cz>,
       szepe@pinerecords.com, linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <404260000.1048452717@[10.10.2.4]>
In-Reply-To: <20030323203803.A12220@devserv.devel.redhat.com>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz> <200303231938.h2NJcAq14927@devserv.devel.redhat.com> <20030323194423.GC14750@atrey.karlin.mff.cuni.cz> <1048448838.1486.12.camel@phantasy.awol.org> <20030323195606.GA15904@atrey.karlin.mff.cuni.cz> <1048450211.1486.19.camel@phantasy.awol.org> <402760000.1048451441@[10.10.2.4]> <20030323203803.A12220@devserv.devel.redhat.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The distros inherently have a conflict of interest getting changes merged
>> back into mainline ... it's time consuming to do, it provides them no real
>> benefit (they have to maintain their huge trees anyway), and it actively
>> damages the "value add" they provide.
> 
> I take a strong objection to this. I can't speak for all distros, but I
> know that Red Hat has a strong preference to get things merged upstream as
> soon as possible. I think you are absolutely wrong about the "no
> real benefit" part and that you totally misunderstand what value add
> distributions provide.

Well, that is a minefield of subjective opinions. Yes, the distros merge
stuff back ... but there's not enough of it going on. RHAS and UL are
*massively* diverged. There are also changes that are in just about every
distro that aren't back in mainline. I fail to see the point of that ...
people complain about problems with things like O(1) scheduler, and yet
the distros all distribute it ... very odd.

The question of "what is mainline 2.4 for anyway" is becoming increasingly
interesting, especially as fewer people are using it. If there was more
of a common base between the distros, there would be IMHO less duplicated
work.

>> If that's people's attitude ("you should use a vendor"), then we need a 
>> 2.4-fixed tree to be run by somebody with an interest in providing 
>> critical bugfixes to the community with no distro ties.
> 
> this is not about distros or vendors (yes IBM is a linux vendor too). at
> all. Marcelo is in a tough position; either he releases an emergency
> kernel with a patch applied that seems to have a few corner case issues,
> or he starts to rush out 2.4.21 based on the current
> 2.4.21-pre codebase. Given that there are other bugs in 2.4.20
> that makes people say "but THIS needs to be in too", I can see
> that becoming a very fuzzy thing pretty quick. Apparantly Marcelo decided
> to go for the "get 2.4.21 out soon" approach..... 

I'm not so worried about what Marcelo chooses to do with this particular
issue - that's his call. However, I'm extremely concerned by the general
"you should be using a vendor kernel" attitude.

M.
