Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129601AbRBBUxU>; Fri, 2 Feb 2001 15:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129927AbRBBUxK>; Fri, 2 Feb 2001 15:53:10 -0500
Received: from jalon.able.es ([212.97.163.2]:26067 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129601AbRBBUxD>;
	Fri, 2 Feb 2001 15:53:03 -0500
Date: Fri, 2 Feb 2001 21:52:54 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Christoph Rohland <cr@sap.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] tmpfs for 2.4.1
Message-ID: <20010202215254.C2498@werewolf.able.es>
In-Reply-To: <20010123205315.A4662@werewolf.able.es> <m3lmrqrspv.fsf@linux.local> <95csna$vb6$1@cesium.transmeta.com> <m3puh1que4.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <m3puh1que4.fsf@linux.local>; from cr@sap.com on Fri, Feb 02, 2001 at 10:57:55 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.02 Christoph Rohland wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> > What happened with this being a management tool for shared memory
> > segments?!
> 
> Unfortunately we lost this ability in the 2.4.0-test series. SYSV shm
> now works only on an internal mounted instance and does not link the
> directory entry to the deleted state of the segment. 
> 

Mmmmmm, does this mean that mounting /dev/shm is no more needed ?
One step more towards easy 2.2 <-> 2.4 switching...

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac1 #2 SMP Fri Feb 2 00:19:04 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
