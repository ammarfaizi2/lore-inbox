Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130383AbRACToe>; Wed, 3 Jan 2001 14:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130374AbRACToY>; Wed, 3 Jan 2001 14:44:24 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31808 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130231AbRACToI>; Wed, 3 Jan 2001 14:44:08 -0500
Date: Wed, 3 Jan 2001 20:13:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Cc: linux-kernel@vger.kernel.org, linux-parport@torque.net
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
Message-ID: <20010103201344.A3203@athlon.random>
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain>; from peter.osterlund@mailbox.swipnet.se on Wed, Jan 03, 2001 at 07:44:19PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 07:44:19PM +0100, Peter Osterlund wrote:
> Is there a better way to fix this problem?

It looks the simpler fix to me (main loop needs someway to handle errors
anyways) but ask Tim too.

Another way to fix it is to loop in interruptible mode inside lp_error waiting
the error to go away.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
