Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131328AbQKAPlc>; Wed, 1 Nov 2000 10:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131275AbQKAPlW>; Wed, 1 Nov 2000 10:41:22 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:32822 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131225AbQKAPlJ>; Wed, 1 Nov 2000 10:41:09 -0500
Date: Wed, 1 Nov 2000 16:41:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Jeff V. Merkey" <jmerkey@.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001101164106.F9774@athlon.random>
In-Reply-To: <E13qj56-0003h9-00@pmenage-dt.ensim.com> <39FF3D53.C46EB1A8@timpanogas.org> <20001031140534.A22819@work.bitmover.com> <39FF4488.83B6C1CE@timpanogas.org> <20001031142733.A23516@work.bitmover.com> <39FF49C8.475C2EA7@timpanogas.org> <20001101023010.G13422@athlon.random> <20001031183809.C9733@.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001031183809.C9733@.timpanogas.org>; from jmerkey@.timpanogas.org on Tue, Oct 31, 2000 at 06:38:09PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 06:38:09PM -0700, Jeff V. Merkey wrote:
> [..] It's all rather complicated, and I think alien
> to Unix folks. [..]

That has _nothing_ to do with software. That's only has to do with the IA32
hardware.

If you only switch the stack during context switching then you _can't_ provide
memory protection between different tasks. Period.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
