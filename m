Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVDEJog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVDEJog (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVDEJnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:43:15 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.29]:24470 "EHLO smtp2.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261652AbVDEJgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:36:44 -0400
X-ME-UUID: 20050405093640826.C9A4D1C001DA@mwinf0206.wanadoo.fr
Date: Tue, 5 Apr 2005 11:33:20 +0200
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Matthew Wilcox <matthew@wil.cx>,
       Greg KH <greg@kroah.com>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org, Jes Sorensen <jes@trained-monkey.org>,
       linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050405093320.GA26377@pegasos>
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404183909.GI18349@parcelfarce.linux.theplanet.co.uk> <42519BCB.2030307@pobox.com> <20050404202706.GB3140@pegasos> <4251A7E8.6050200@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4251A7E8.6050200@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jeff, ...

If i can believe what i see in :

  http://linux.bkbits.net:8080/linux-2.6/anno/drivers/net/tg3.c@1.255?nav=index.html|src/|src/drivers|src/drivers/net|related/drivers/net/tg3.c|cset@1.2181.28.39

(which may or may not be correct and complete, since i am not really familiar
with bk and how things where back then), you imported the tg3 firmware in our
bk repo on 2002/03/07 :

2002/03/07 jgarzik            | 	0x00000000, 0x10000003, 0x00000000, 0x0000000d, 0x0000000d, 0x3c1d0800,
2002/03/07 jgarzik            | 	0x37bd3ffc, 0x03a0f021, 0x3c100800, 0x26100000, 0x0e000018, 0x00000000,
2002/03/07 jgarzik            | 	0x0000000d, 0x3c1d0800, 0x37bd3ffc, 0x03a0f021, 0x3c100800, 0x26100034,

The changelog importing them says :

  Merge new tg3 version 0.96 gigabit ethernet driver. 

So i suppose this comes from a pre-bk tree or something, altough the whole
copyright of that file is marked as copyrighted by you and davem.

Where did you get that firmware from and under which licence ? And would you
approve of a patch marking this blob as non-GPLed, and we could add the
licencing text for it that you originally got it under ? Does this make sense ?

Or do you believe i should go ahead and approach broadcom, claiming something
like the following :

  "We have noticed that an unlicenced firmware blob whose copyright you hold
  is present in the linux tg3 driver. In order to clarify this situation, we
  would like to know if it is ok to distribute said binary firmware blob, and
  know under what licence it comes."

BTW, also, i am not entirely sure if such changes can be done only by you, or
need approval of everyone who contributed GPL code to that file since then,
altough i believe that since the firmware blob is an agregation, it should not
matter, and only the original checkin you did is the one we need to account
for.

I understand this is bothersome to everyone, but the code base will be a
cleaner one once we solve this issue, don't you think ? 

Friendly,

Sven Luther


