Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276684AbRJKShn>; Thu, 11 Oct 2001 14:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276689AbRJKShd>; Thu, 11 Oct 2001 14:37:33 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:30111 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S276684AbRJKShR>; Thu, 11 Oct 2001 14:37:17 -0400
Date: Thu, 11 Oct 2001 19:19:51 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@orange.csi.cam.ac.uk>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: Christopher Friesen <cfriesen@nortelnetworks.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: unkillable process in R state?
In-Reply-To: <20011011192520.A27394@dea.linux-mips.net>
Message-ID: <Pine.SOL.4.33.0110111918330.24868-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001, Ralf Baechle wrote:

> On Thu, Oct 11, 2001 at 12:48:22PM -0400, Christopher Friesen wrote:
>
> > I have a process (an instance of a find command) that seems to be
> > unkillable (ie kill -9 <pid> as root doesn't work).
> >
> > Top shows it's status as R.
> >
> > Is there anything I can do to kill the thing? It's taking up all unused cpu
> > cycles (currently at 97.4%).
>
> I assume that's kapm-idled.  That's normal, it's job is exactly burning
> unused cycles.

No. He said it's an instance of find.

Stuck in R, though - some sort of loop? Christopher, can you attach gdb to
it and see what's happening?


James.
-- 
"Our attitude with TCP/IP is, `Hey, we'll do it, but don't make a big
system, because we can't fix it if it breaks -- nobody can.'"

"TCP/IP is OK if you've got a little informal club, and it doesn't make
any difference if it takes a while to fix it."
		-- Ken Olson, in Digital News, 1988

