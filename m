Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269491AbRGaVyf>; Tue, 31 Jul 2001 17:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269492AbRGaVyP>; Tue, 31 Jul 2001 17:54:15 -0400
Received: from marine.sonic.net ([208.201.224.37]:29715 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S269491AbRGaVyG>;
	Tue, 31 Jul 2001 17:54:06 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Tue, 31 Jul 2001 14:54:13 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Cc: Rik van Riel <riel@conectiva.com.br>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010731145413.C3456@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010731232947.C13258@emma1.emma.line.org>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 11:29:47PM +0200, Matthias Andree wrote:
> If I understand SUS v2 correctly, fsync() must sync meta data
> corresponding to the file.


Where can I find a common definition for "meta data."

For example, I consider meta data to be things kept in the inode only
(size, timestamps, permissions).  Indirect blocks, maybe.  But, considering
how, in the unix world, file names are NOT associated with files, I have
never considered file names to be meta data.  Instead, file names is a set
of data associated with special files known as "directories."  So, it is
obvious, to me, that expecting fsync to sync changes to directory entries
is silly.

Obviously, however, you have a different definition of what meta data is.

Does SUS2 provide a definition for meta data?

A quick glance at the webside didn't turn anything up for me, but I would
not be surprised that I may have missed it.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
