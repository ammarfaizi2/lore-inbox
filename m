Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276231AbRJPNgz>; Tue, 16 Oct 2001 09:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRJPNgp>; Tue, 16 Oct 2001 09:36:45 -0400
Received: from Expansa.sns.it ([192.167.206.189]:61189 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S276231AbRJPNg3>;
	Tue, 16 Oct 2001 09:36:29 -0400
Date: Tue, 16 Oct 2001 15:36:13 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Anuradha Ratnaweera <anuradha@gnu.org>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: VM
In-Reply-To: <20011016141429.A29907@bee.lk>
Message-ID: <Pine.LNX.4.33.0110161503300.17096-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I used bot VM in many situations and with many different HWs.
I came to the conclusion that  actually  none of the two VMs is suitable
for every use.
aa VM deals better because of its design on my web servers, with a non
eccessive amount of memory, and with mysql and oracle databases.

When I talk of AA vm i mean the 2.4.13preXaa1 versions.

Unfortunatelly I have also found a problem with
some situations when the VM is higly stressed, but Andrea was very kind to
this report, and now I hope it has gone away (will test this afternoon).

aa VM was also good with dualAthlon servers used for montecarlo
simulations, but also here, VM was not really stressed, and the system has
just 1 GB of RAM.

Rik VM in its later version is dealing better with Ultrasparc64
quadriprocessor with 4 GB RAM. But in this case we are talking of very
very stressed system, with hundreds of huge processes, doing a lot of swap
in/out, and with 8 GB swap space.
I am just sorry that i have access to this machine just from times to
times, when a critical problem appears, but this is a production server.

The reason is the aa VM is more predictable, but rik's one actually
seems to be smarter under very very stressed situations.

I do not care which VM is simpler, nor which is faster. I loock for
predictability, since this is the most important thing on the servers I am
administering. Under a special situation I need something maybe less
predictable, but smarter to manage a stressed system.

80%... 5%... I do not care for exact numbers actually, I will care in
future, if the situation comes to the point that both VMs will be quite
good for everything. anyway it is a good strategy to follow two different
way, since they are progressing quite welll together, with competition,
and also (I hope) reciprocal help (just to be able to read the code of the
other is a good help:) ).

Just now I am sorry I have to deal with this choice for every mission
critical server I have. I would like a single VM that is good for
everything, but I understand that this is the most difficoult thing to
reach, because the casistinc is going to be more and more complex, with
technology evolution, and
with time it will be even worse.


Luigi


On Tue, 16 Oct 2001, Anuradha Ratnaweera wrote:

> On Tue, Oct 16, 2001 at 01:57:41AM +0000, Linus Torvalds wrote:
> >
> > oh..  say ..  everything.
> >
> > "complex" != "smart".
>
> and almost always
>
>     "simple" == "better"
>
> Anuradha
>
> --
>
> Debian GNU/Linux (kernel 2.4.12)
>
> Absolutum obsoletum.  (If it works, it's out of date.)
> 		-- Stafford Beer
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

