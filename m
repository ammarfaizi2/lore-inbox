Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129927AbRBBU4U>; Fri, 2 Feb 2001 15:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129854AbRBBU4L>; Fri, 2 Feb 2001 15:56:11 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:21000 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130058AbRBBU4A>; Fri, 2 Feb 2001 15:56:00 -0500
Message-ID: <3A7B1EDC.DA2588BA@transmeta.com>
Date: Fri, 02 Feb 2001 12:55:56 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: Christoph Rohland <cr@sap.com>, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] tmpfs for 2.4.1
In-Reply-To: <20010123205315.A4662@werewolf.able.es> <m3lmrqrspv.fsf@linux.local> <95csna$vb6$1@cesium.transmeta.com> <m3puh1que4.fsf@linux.local> <20010202215254.C2498@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:
> 
> On 02.02 Christoph Rohland wrote:
> > "H. Peter Anvin" <hpa@zytor.com> writes:
> >
> > > What happened with this being a management tool for shared memory
> > > segments?!
> >
> > Unfortunately we lost this ability in the 2.4.0-test series. SYSV shm
> > now works only on an internal mounted instance and does not link the
> > directory entry to the deleted state of the segment.
> >
> 
> Mmmmmm, does this mean that mounting /dev/shm is no more needed ?
> One step more towards easy 2.2 <-> 2.4 switching...
> 

In some ways it's kind of sad.  I found the /dev/shm interface to be
rather appealing :)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
