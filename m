Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155027AbQAaAZN>; Sun, 30 Jan 2000 19:25:13 -0500
Received: by vger.rutgers.edu id <S155031AbQAaAXI>; Sun, 30 Jan 2000 19:23:08 -0500
Received: from [216.101.162.242] ([216.101.162.242]:33053 "EHLO pizda.ninka.net") by vger.rutgers.edu with ESMTP id <S155066AbQAaAWH>; Sun, 30 Jan 2000 19:22:07 -0500
Date: Sun, 30 Jan 2000 20:27:42 -0800
Message-Id: <200001310427.UAA03372@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: andre@suse.com
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.rutgers.edu
In-reply-to: <Pine.LNX.4.10.10001302024210.18120-100000@home.suse.com> (message from Andre Hedrick on Sun, 30 Jan 2000 20:27:18 -0800 (PST))
Subject: Re: DMA changes in 2.3.41 - how the f* do I get this working on ARM?
References: <Pine.LNX.4.10.10001302024210.18120-100000@home.suse.com>
Sender: owner-linux-kernel@vger.rutgers.edu

   Date: Sun, 30 Jan 2000 20:27:18 -0800 (PST)
   From: Andre Hedrick <andre@suse.com>

   It is important that we all work togather, but there has been at
   least one other occassion that this code has been nuke by accident.
   And yes, pissed off never worked again since the begin of the hand
   off of IDE between 2.1.112 and 2.1.122..  Russell, I am in your
   corner to help fix this.

This was an intentional nuke.  And I am working offline with Russell,
Jakub, and Alan to address the issues.

I am very sure that making the new (and documented) interfaces work
properly for him is going to be preferred to sticking the flush hacks
back in.  I say this, because the new interfaces will create a
situation where properly written PCI drivers of any type will work
for his, and every, platform wrt. DMA issues not just the ones where
he happens to sprinkle his dma flush calls into.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
