Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271744AbRH2BQB>; Tue, 28 Aug 2001 21:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271779AbRH2BPv>; Tue, 28 Aug 2001 21:15:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47624 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271744AbRH2BPk>; Tue, 28 Aug 2001 21:15:40 -0400
Date: Tue, 28 Aug 2001 18:13:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Roman Zippel <zippel@linux-m68k.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <20010829002715Z16351-32384+944@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0108281812200.978-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Aug 2001, Daniel Phillips wrote:
>
>     min(host->scsi.SCp.this_residual, (unsigned) DMAC_BUFFER_SIZE / 2);

Sure.

If you put the type information explicitly, you can get it right.

Which is, btw, _exactly_ why the min() function takes the type explicitly.

		Linus


