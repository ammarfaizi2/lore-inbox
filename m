Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281185AbRKTRmr>; Tue, 20 Nov 2001 12:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281188AbRKTRmi>; Tue, 20 Nov 2001 12:42:38 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:45575 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S281185AbRKTRm3>;
	Tue, 20 Nov 2001 12:42:29 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200111201742.UAA03009@ms2.inr.ac.ru>
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server --- linux 2.4.15pre5 client
To: trond.myklebust@fys.uio.no (Trond Myklebust)
Date: Tue, 20 Nov 2001 20:42:13 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <shsn11i31g2.fsf@charged.uio.no> from "Trond Myklebust" at Nov 19, 1 10:17:33 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I forgot to add: The socket fasync lists use spinlocking in the same
> was as RPC does, with sock_fasync() setting
> write_lock_bh(&sk->callback_lock), and sock_def_write_space()
> doing read_lock(&sk->callback_lock).
> 
> So that would deadlock with the QDIO driver in the exact same manner
> as the RPC stuff (albeit probably a lot less frequently).

Please, elaborate. I do not see any way.

Alexey

