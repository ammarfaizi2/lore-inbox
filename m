Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129296AbRBCU2P>; Sat, 3 Feb 2001 15:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129693AbRBCU1z>; Sat, 3 Feb 2001 15:27:55 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:24076 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129296AbRBCU1t>; Sat, 3 Feb 2001 15:27:49 -0500
Message-ID: <3A7C69AB.9C7603A8@transmeta.com>
Date: Sat, 03 Feb 2001 12:27:23 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>
CC: "J . A . Magallon" <jamagallon@able.es>, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] tmpfs for 2.4.1
In-Reply-To: <20010123205315.A4662@werewolf.able.es>
		<m3lmrqrspv.fsf@linux.local> <95csna$vb6$1@cesium.transmeta.com>
		<m3puh1que4.fsf@linux.local> <20010202215254.C2498@werewolf.able.es>
		<3A7B1EDC.DA2588BA@transmeta.com> <m3d7d0pwnr.fsf@linux.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland wrote:
> 
> "H. Peter Anvin" <hpa@transmeta.com> writes:
> 
> > > Mmmmmm, does this mean that mounting /dev/shm is no more needed ?
> > > One step more towards easy 2.2 <-> 2.4 switching...
> 
> Yes, it is no longer needed. You will need for POSIX shm, but there
> are not a lot of program out there using it.
> 

Do you need it for POSIX shm or not... if so, I would say you do need it
(even if it's going to take some time until POSIX shm becomes widely
used.)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
