Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266368AbSKLJzC>; Tue, 12 Nov 2002 04:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266377AbSKLJzC>; Tue, 12 Nov 2002 04:55:02 -0500
Received: from zork.zork.net ([66.92.188.166]:62408 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S266368AbSKLJzB>;
	Tue, 12 Nov 2002 04:55:01 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: devfs
References: <20021112093259.3d770f6e.spyro@f2s.com>
	<1037094221.16831.21.camel@bip>
	<20021112094949.GE17478@higherplane.net>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: NON-SEQUITUR, IGNORATIO ELENCHI
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: : WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Tue, 12 Nov 2002 10:01:50 +0000
In-Reply-To: <20021112094949.GE17478@higherplane.net> (john slee's message
 of "Tue, 12 Nov 2002 20:49:49 +1100")
Message-ID: <6uadkf9kdt.fsf@zork.zork.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  john slee quotation:

> On Tue, Nov 12, 2002 at 10:43:41AM +0100, Xavier Bestel wrote:
>> I'm wondering if a totally userspace solution could replace devs ?
>> Something using hotplug + sysfs and creating directories/nodes as
>> they appear on the system. This way, the policy (how do I name
>> what) could be moved out of the kernel.
>
> curious!  you mean similar to (and a logical extension of) the
> 'disks' command in solaris?  at least i think thats what its
> called...

Except that a /sbin/hotplug er, "solution", would be dynamic.  I had
always assumed in the back of my mind that such a solution would make
devfs go away some day, although I don't think I actually read about
it anywhere.

Actually, here's a question: are /sbin/hotplug upcalls serialized in
some fashion?  I'd hate to online a thousand devices in my disk array
and have the machine forkbomb itself.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
