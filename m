Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261850AbREPJpe>; Wed, 16 May 2001 05:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbREPJpY>; Wed, 16 May 2001 05:45:24 -0400
Received: from oxmail2.ox.ac.uk ([163.1.2.1]:38636 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S261850AbREPJpQ>;
	Wed, 16 May 2001 05:45:16 -0400
Date: Wed, 16 May 2001 10:45:04 +0100
From: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
To: Alexander Viro <viro@math.psu.edu>
Cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010516104504.A21358@sable.ox.ac.uk>
In-Reply-To: <80x0jOtXw-B@khms.westfalen.de> <Pine.GSO.4.21.0105160335030.24199-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0105160335030.24199-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, May 16, 2001 at 03:43:37AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> thing, we could turn mount(2) into
> 	open appropriate fs type
> 	convince the sucker that you are allowed, tell which device you want,
> etc.
> 	open mountpoint
> 	mount(fs_fd, dir_fd)
> Would work like charm, especially since we could fit the network filesystems
> into the same scheme and get rid of the kludges a-la ncpfs mount sequence.
> 
> There's only one sore spot: how'd you mount _that_ fs? ;-)

Start up init with fs_fd on file descriptor 3 and init can put it
where it likes.

--Malcolm

-- 
Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Unix Systems Programmer
Oxford University Computing Services
