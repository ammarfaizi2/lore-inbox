Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289109AbSANWeo>; Mon, 14 Jan 2002 17:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289110AbSANWe0>; Mon, 14 Jan 2002 17:34:26 -0500
Received: from [217.9.226.246] ([217.9.226.246]:5760 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S289105AbSANWeE>; Mon, 14 Jan 2002 17:34:04 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Oliver.Neukum@lrz.uni-muenchen.de, yodaiken@fsmlabs.com,
        phillips@bonn-fries.net (Daniel Phillips),
        arjan@fenrus.demon.nl (Arjan van de Ven),
        zippel@linux-m68k.org (Roman Zippel), linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16QB8b-0002K8-00@the-village.bc.nu>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <E16QB8b-0002K8-00@the-village.bc.nu>
Date: 15 Jan 2002 00:34:01 +0200
Message-ID: <87sn98ftpi.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

Oliver> You can have an rt task block on a lock held by a normal task that was 
Oliver> preempted by a rt task of lower priority. The same problem as with the 
Oliver> sched_idle patches.
>> 
>> This can happen with a non-preemptible kernel too. And it has nothing to
>> do with scheduling policy.

Alan> So why bother adding pre-emption. As you keep saying - it doesnt
Alan> gain anything

Nope. I don't. I said (at least in the above) it didn't hurt.

One can consider a non-preemptible kernel as a special kind of
priority inversion, preemptible kernel will eliminate _that_ case of
priority inversion.

Regards,
-velco

