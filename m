Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317746AbSFLR0x>; Wed, 12 Jun 2002 13:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317747AbSFLR0w>; Wed, 12 Jun 2002 13:26:52 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:3516 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S317746AbSFLR0w>;
	Wed, 12 Jun 2002 13:26:52 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200206121725.VAA16261@sex.inr.ac.ru>
Subject: Re: Multicast netlink for non-root process
To: jmorris@intercode.com.au (James Morris)
Date: Wed, 12 Jun 2002 21:25:59 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Mutt.LNX.4.44.0206121417060.31953-100000@blackbird.intercode.com.au> from "James Morris" at Jun 12, 2 02:25:56 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Are you referring to a netlink security model which we discussed in March 
> (off-list), where security is be implemented on a per-message basis?

Yes.

> All access permission checks are now done via send/recvmsg.

But you seem to raise CAP_NET_ADMIN at each netlink_broadcast,
so we do not get desired effect.

Anyway, I think the patch is good, what a pity that I forgot about it.
For now we accept Andi's patch, it is simpler. Yours can be defered
to 2.5.

Alexey
