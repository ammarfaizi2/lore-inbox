Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274239AbRISWi3>; Wed, 19 Sep 2001 18:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274238AbRISWiT>; Wed, 19 Sep 2001 18:38:19 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26374 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272282AbRISWiL>; Wed, 19 Sep 2001 18:38:11 -0400
Subject: Re: 2.4 Success story
To: jhingber@ix.netcom.com (Jeffrey Ingber)
Date: Wed, 19 Sep 2001 23:43:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1000938233.2152.10.camel@DESK-2> from "Jeffrey Ingber" at Sep 19, 2001 06:23:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jq3z-000467-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I agree.  This is a fantastic kernel - so good infact, it'll probably be
> awhile before I try out a new one unless some other issue(s) comes up.=20
> I had a nagging problem with XF864 dying with Sig'11 on SMP and this has
> completely cleared it up. =20

As far as I can tell the XFree problem was almost certainly the LDT thing, 
and if so then it was fixed when I merged Linus changes, so should also be
fine in Linux tree now.

If not then some hard looking is needed to make sure whatever was the fix
is definitely in Linus tree
