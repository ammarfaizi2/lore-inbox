Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130352AbQKLJ4s>; Sun, 12 Nov 2000 04:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130355AbQKLJ43>; Sun, 12 Nov 2000 04:56:29 -0500
Received: from CPE-61-9-148-41.vic.bigpond.net.au ([61.9.148.41]:25843 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S130352AbQKLJ4Z>; Sun, 12 Nov 2000 04:56:25 -0500
Date: Sun, 12 Nov 2000 20:58:48 +1100
From: john slee <indigoid@higherplane.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: dake@staszic.waw.pl, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11-pre3 [gus_midi.c breakage]
Message-ID: <20001112205848.E19275@higherplane.net>
In-Reply-To: <Pine.LNX.4.10.10011111914170.7609-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10011111914170.7609-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Nov 11, 2000 at 07:22:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 07:22:06PM -0800, Linus Torvalds wrote:
>-----
>  - pre3:
>     - Bartlomiej Zolnierkiewicz: sound and drm driver init fixes and
>       cleanups

this breaks for me, gcc 2.95.2:

gus_midi.c:206: parse error before `gus_midi_init'
gus_midi.c:207: warning: return-type defaults to `int'
gus_midi.c:207: conflicting types for `gus_midi_init'
gus.h:26: previous declaration of `gus_midi_init'
gus_midi.c: In function `gus_midi_init':
gus_midi.c:213: warning: `return' with no value, in function returning non-void
gus_midi.c:221: warning: `return' with no value, in function returning non-void

j.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
