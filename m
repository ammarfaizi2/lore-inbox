Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286293AbRLJQAO>; Mon, 10 Dec 2001 11:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286294AbRLJQAE>; Mon, 10 Dec 2001 11:00:04 -0500
Received: from srexchimc2.lss.emc.com ([168.159.40.71]:31494 "EHLO
	srexchimc2.lss.emc.com") by vger.kernel.org with ESMTP
	id <S286293AbRLJP7p>; Mon, 10 Dec 2001 10:59:45 -0500
Message-ID: <B595A948887ED41185130000D1899D880272C8EB@srstaubach.lss.emc.com>
From: "cardente, john" <cardente_john@emc.com>
To: "'Jeff V. Merkey '" <jmerkey@vger.timpanogas.org>
Cc: "'David S. Miller '" <davem@redhat.com>,
        "'lm@bitmover.com '" <lm@bitmover.com>,
        "'davidel@xmailserver.org '" <davidel@xmailserver.org>,
        "'rusty@rustcorp.com.au '" <rusty@rustcorp.com.au>,
        "'Martin.Bligh@us.ibm.com '" <Martin.Bligh@us.ibm.com>,
        "'riel@conectiva.com.br '" <riel@conectiva.com.br>,
        "'lars.spam@nocrew.org '" <lars.spam@nocrew.org>,
        "'alan@lxorguk.ukuu.org.uk '" <alan@lxorguk.ukuu.org.uk>,
        "'hps@intermeta.de '" <hps@intermeta.de>,
        "'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>,
        "'jmerkey@timpanogas.org '" <jmerkey@timpanogas.org>
Subject: RE: SMP/cc Cluster description
Date: Mon, 10 Dec 2001 10:59:38 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>I know what the PCI cards do.  I was the person who pushed
>marty Albert, the Chairman of the Dolphin Board at the time in 
>1995 to pursue design work on them.  I also worked with Justin 
>Rattner (I saw one of your early prototype boxes in 1996 in his labs).  

Ahh, sometimes it's hard to gauge "understanding" on this list  ;-)
Good idea BTW. For a while we looked into using those cards
to implement a non-cc NUMA cluster system. That was a while
ago, however, and I've managed to forget most of the details. Also,
with the assimilation of DG into EMC I've tossed most of my dolphin
specs.


>Those stubs were aweful short for the lost slot in your 
>system, and I am surprised you did not get signal skew.  Those
>stubs had to be 1.5 inches long :-).

Yes, I spent many hours in the lab hunting for signal integrity
issues. As you may guess it was not always easy being a third
party agent on an intel bus...


>Wrong.  There is a small window where you can copy into a 
>remote nodes memory.

As I said above I tossed by P2B spec so I cant refresh my memory
on this. Did this work like reflective memory or do you scribble
on a piece of memory and then poke the card to send to another node?
Its my guess that the former prohibits the memory being cacheable
while the latter relies on compliant SW and therefore doesnt afford
transparent cross node memory references. Are either of these right?


>It's OK.  We love DG and your support of SCI.  Keep up the good 
>work.

Wish that I was but sadly I'm not. DG was my first job after grad school
and cutting my teeth on the ccNUMA stuff was simply an outstanding
experience.
Those were good days....

Thanks for the reply...
john

ps. I got two of the older PCI cards sitting in my desk drawer.
Now you've got me considering pulling those guys out and having
some fun!!!
