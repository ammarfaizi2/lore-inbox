Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbRAWMpW>; Tue, 23 Jan 2001 07:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130895AbRAWMpN>; Tue, 23 Jan 2001 07:45:13 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:62344 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130552AbRAWMpA>; Tue, 23 Jan 2001 07:45:00 -0500
Message-ID: <3A6D7E95.C86BF650@uow.edu.au>
Date: Tue, 23 Jan 2001 23:52:37 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "'Linux Kernel List'" <linux-kernel@vger.kernel.org>
Subject: Re: [OT?] Coding Style
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCC5@zcard00g.ca.nortel.com>,
		<28560036253BD41191A10000F8BCBD116BDCC5@zcard00g.ca.nortel.com> <20010122082254.D9530@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> 
> Please don't listen to this.  The only place you really want comments is
> 
>     a) at the top of files, describing the point of the file;
>     b) at the top of functions, if the purpose of the function is not obvious;
>     c) in line, when the code is not obvious.

One other _very_ useful place: in header files.  This is a place where
a comment-per-line is appropriate.

For example, include/linux/fs.h.  Shame about `struct inode' though.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
