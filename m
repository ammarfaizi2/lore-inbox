Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261151AbREORAt>; Tue, 15 May 2001 13:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261155AbREORA3>; Tue, 15 May 2001 13:00:29 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:52748 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S261151AbREORA2>;
	Tue, 15 May 2001 13:00:28 -0400
Date: Tue, 15 May 2001 19:00:12 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: LANANA: To Pending Device Number Registrants
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3B01609C.CD9EBFF4@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue May 15 2001 , Linus Torvalds wrote :
> On Tue, 15 May 2001, Neil Brown wrote: 
> > 
> > Finally, how do I say that I want the root filesystem to be on a 
> > particular "mdp" device+partition. I cannot assume that my device 
> > will be the first to register with the "disk" layer, so I cannot be 
> > sure that "root=/dev/diska1" will work. 
> 
> You have never been able to really assume that. Disks move around. 
> 
> A lot of people seem to think that controller type or location on the PCI 
> bus should somehow have some "meaning", and that it guarantees that the 
> disks don't move in the namespace. That's crap. You can do that in user 
> space ("what controller are you on?") if you really really care. 

So what is your solution for preventing a boot failure after disks/partitions
change ?
volume labels/UUID ?


-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
