Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289159AbSAVFPn>; Tue, 22 Jan 2002 00:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289160AbSAVFPY>; Tue, 22 Jan 2002 00:15:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64784 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289159AbSAVFPQ>; Tue, 22 Jan 2002 00:15:16 -0500
Date: Mon, 21 Jan 2002 21:14:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Patch for ymfpci in 2.5.x
In-Reply-To: <20020122001125.A19661@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33.0201212113230.1469-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Jan 2002, Pete Zaitcev wrote:
>
> I think something like this would be better than one more
> totally nonsesical random #define:

No.

Why don't you call it something SANE, like "default_gain" or something.

Anybody who uses variable names like "le_0x40000000" is just horribly
misguided. Never EVER do that. You're better off just writing it out as
"cpu_to_le32(0x40000000)" in that case.

		Linus

