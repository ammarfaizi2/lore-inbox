Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbRFLPCu>; Tue, 12 Jun 2001 11:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbRFLPCk>; Tue, 12 Jun 2001 11:02:40 -0400
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:65262 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S261666AbRFLPCZ>; Tue, 12 Jun 2001 11:02:25 -0400
Date: Tue, 12 Jun 2001 16:01:49 +0100 (BST)
From: Jeremy Sanders <jss@ast.cam.ac.uk>
To: "David S. Miller" <davem@redhat.com>
cc: Russell King <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: rsync hangs on RedHat 2.4.2 or stock 2.4.4
In-Reply-To: <15142.11907.782662.581523@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0106121601270.10732-100000@xpc1.ast.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2001, David S. Miller wrote:

>
> Russell King writes:
>  > At the time I suggested it was because of a missing wakeup in 2.4.2 kernels,
>  > but I was shouted down for using 2.2.15pre13.  Since then I've seen these
>  > reports appear on lkml several times, each time without a solution nor
>  > explaination.
>  >
>  > Oh, and yes, we're still using the same setup here at work, and its running
>  > fine now - no rsync lockups.  I'm not sure why that is. ;(
>
> Look everyone, it was determined to be a deadlock because of some
> interaction between how rsync sets up it's communication channels
> with the ssh subprocess, readas: userland bug.

I'm not using ssh! This is from local disk to local disk!

Jeremy

-- 
Jeremy Sanders <jss@ast.cam.ac.uk>  http://www-xray.ast.cam.ac.uk/~jss/
Pembroke College, Cambridge. UK   Institute of Astronomy, Cambridge. UK

