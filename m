Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273519AbRIQH5a>; Mon, 17 Sep 2001 03:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273524AbRIQH5U>; Mon, 17 Sep 2001 03:57:20 -0400
Received: from jalon.able.es ([212.97.163.2]:37251 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S273519AbRIQH5Q>;
	Mon, 17 Sep 2001 03:57:16 -0400
Date: Mon, 17 Sep 2001 09:56:40 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Chmouel Boudjnah <chmouel@mandrakesoft.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac11
Message-ID: <20010917095640.C4490@werewolf.able.es>
In-Reply-To: <200109170049.f8H0nkEa008317@sleipnir.valparaiso.cl> <m366ail5pp.fsf@giants.mandrakesoft.com> <shsvgiicl7l.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <shsvgiicl7l.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Mon, Sep 17, 2001 at 09:47:42 +0200
X-Mailer: Balsa 1.2.pre3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010917 Trond Myklebust wrote:
>
>That particular code is only called if something closes a file on
>which POSIX locks are applied. Init doesn't use locking.
>The patch *is* required in Alan's tree. Without it, 2 processes that
                ^^^^^^^^ ???
>lock the same file can race and corrupt the i_flock list.
>

I have checked and I suppose you want to say that it is INCLUDED in
Alan's tree...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.9-ac11 #1 SMP Mon Sep 17 00:00:56 CEST 2001 i686
