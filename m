Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290061AbSAKSi6>; Fri, 11 Jan 2002 13:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290062AbSAKSis>; Fri, 11 Jan 2002 13:38:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6672 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290061AbSAKSie>; Fri, 11 Jan 2002 13:38:34 -0500
Date: Fri, 11 Jan 2002 10:36:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Patch for ymfpci in 2.5.x
In-Reply-To: <20020111121431.A10147@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33.0201111034070.3952-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Jan 2002, Pete Zaitcev wrote:
>
> I am terribly sorry, but an additional fixup is needed,
> as identified by Anders Rune Jensen (mental note - always
> cc submissions to linux-kernel. So many good eyeballs).

It would have been even saner to give that bit some sane name, and have
something like

	#define YMFPCI_XXXBIT (__constant_cpu_to_le32(0x40000000))

instead of creating a totally nonsensical random number.

I applied your patch, but if I had created that code I would be too
ashamed to post such a patch on a public mailing list.

		Linus

