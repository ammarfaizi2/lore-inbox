Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288897AbSATSWI>; Sun, 20 Jan 2002 13:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288902AbSATSV6>; Sun, 20 Jan 2002 13:21:58 -0500
Received: from [216.151.155.108] ([216.151.155.108]:62478 "EHLO
	varsoon.denali.to") by vger.kernel.org with ESMTP
	id <S288897AbSATSVy>; Sun, 20 Jan 2002 13:21:54 -0500
To: Richard Kettlewell <rjk@terraraq.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
In-Reply-To: <a2bk6e$t2u$1@ncc1701.cistron.net>
	<Pine.GSO.4.21.0201190627310.3523-100000@weyl.math.psu.edu>
	<Pine.GSO.4.21.0201190627310.3523-100000@weyl.math.psu.edu>
	<8HBE1o7mw-B@khms.westfalen.de> <843d119h0g.fsf@rjk.greenend.org.uk>
From: Doug McNaught <doug@wireboard.com>
Date: 20 Jan 2002 13:21:49 -0500
In-Reply-To: Richard Kettlewell's message of "Sun, 20 Jan 2002 15:30:39 +0000"
Message-ID: <m3k7uchohu.fsf@varsoon.denali.to>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Kettlewell <rjk@terraraq.org.uk> writes:

> If the file descriptor you have was opened O_RDONLY, but you have
> write permission on the file itself, then creating a new name for it
> would allow you to open it O_RDWR.

Are you sure about this?  Permissions are stored in the inode, not the
directory entry. 

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
