Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317753AbSFLRzG>; Wed, 12 Jun 2002 13:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317754AbSFLRzF>; Wed, 12 Jun 2002 13:55:05 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:11452 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S317753AbSFLRzE>;
	Wed, 12 Jun 2002 13:55:04 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200206121754.VAA16380@sex.inr.ac.ru>
Subject: Re: Multicast netlink for non-root process
To: jmorris@intercode.com.au (James Morris)
Date: Wed, 12 Jun 2002 21:54:20 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Mutt.LNX.4.44.0206130341160.1944-100000@blackbird.intercode.com.au> from "James Morris" at Jun 13, 2 03:45:32 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Yep, this version of the patch tried to preserve existing behaviour; any 
> unnecesary cap_raise() calls can be removed as required.

What do you think about setting defaults with some sysctls?
We could have mapping from group number to capability set or simply
bitmask implying CAP_NET_ADMIN.

Alexey
