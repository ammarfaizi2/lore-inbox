Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261771AbRFXLrM>; Sun, 24 Jun 2001 07:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265745AbRFXLrD>; Sun, 24 Jun 2001 07:47:03 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:62982 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S261771AbRFXLq5>; Sun, 24 Jun 2001 07:46:57 -0400
To: Dylan_G@bigfoot.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Annoying kernel behaviour
In-Reply-To: <9h4ft5$1ku$1@ns1.clouddancer.com>
In-Reply-To: <3B33EFC0.D9C930D5@bigfoot.com>    <9h0r6s$fe7$1@ns1.clouddancer.com>    <20010623090542.6019D7846F@mail.clouddancer.com> <3B35C2FA.37F57964@bigfoot.com> <9h4ft5$1ku$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010624114655.3D187784C4@mail.clouddancer.com>
Date: Sun, 24 Jun 2001 04:46:55 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, you wrote:


>bttv0: Bt848 (rev 18) at 00:0f.0, irq: 10, latency: 64, memory: 0xd79ff000

> ** ^^ this worked in 2.2.19 as 
>bttv0: Brooktree Bt848 (rev 18) bus: 0, devfn: 88, irq: 11, memory:
>
>It shouldn't matter, as userspace programs should not be able te fuck te
>kernel over in such a complete instant deadlock.  There is something


Ah, notice that the IRQ shifted?  Perhaps there is something else on
irq 10, such as the SCSI controller?  My video cards always end up on
that IRQ, perhaps the computer is still accessible via the network?



-- 
"Or heck, let's just make the VM a _real_ Neural Network, that self
trains itself to the load you put on the system. Hideously complex and
evil?  Well, why not wire up that roach on the floor, eating that stale
cheese doodle. It can't do any worse job on VM that some of the VM
patches I've seen..."  -- Jason McMullan

ditto
