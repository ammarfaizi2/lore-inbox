Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129108AbRBCVQO>; Sat, 3 Feb 2001 16:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129225AbRBCVQE>; Sat, 3 Feb 2001 16:16:04 -0500
Received: from jalon.able.es ([212.97.163.2]:39159 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129108AbRBCVPx>;
	Sat, 3 Feb 2001 16:15:53 -0500
Date: Sat, 3 Feb 2001 21:46:14 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: "H . Peter Anvin" <hpa@transmeta.com>
Cc: Christoph Rohland <cr@sap.com>, "J . A . Magallon" <jamagallon@able.es>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] tmpfs for 2.4.1
Message-ID: <20010203214614.D923@werewolf.able.es>
In-Reply-To: <20010123205315.A4662@werewolf.able.es> <m3lmrqrspv.fsf@linux.local> <95csna$vb6$1@cesium.transmeta.com> <m3puh1que4.fsf@linux.local> <20010202215254.C2498@werewolf.able.es> <3A7B1EDC.DA2588BA@transmeta.com> <m3d7d0pwnr.fsf@linux.local> <3A7C69AB.9C7603A8@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A7C69AB.9C7603A8@transmeta.com>; from hpa@transmeta.com on Sat, Feb 03, 2001 at 21:27:23 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.03 H. Peter Anvin wrote:
> Christoph Rohland wrote:
> > 
> > "H. Peter Anvin" <hpa@transmeta.com> writes:
> > 
> > > > Mmmmmm, does this mean that mounting /dev/shm is no more needed ?
> > > > One step more towards easy 2.2 <-> 2.4 switching...
> > 
> > Yes, it is no longer needed. You will need for POSIX shm, but there
> > are not a lot of program out there using it.
> > 
> 
> Do you need it for POSIX shm or not... if so, I would say you do need it
> (even if it's going to take some time until POSIX shm becomes widely
> used.)
> 

There was a post recently (that now I can't find), that said the shm
management was done with an interal fs. Was that Posix or sysv shm ?

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac2 #1 SMP Sat Feb 3 10:45:59 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
