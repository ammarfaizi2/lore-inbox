Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289715AbSBER7Z>; Tue, 5 Feb 2002 12:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289708AbSBER7M>; Tue, 5 Feb 2002 12:59:12 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:1031 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S289711AbSBER5w>;
	Tue, 5 Feb 2002 12:57:52 -0500
Date: Tue, 5 Feb 2002 14:21:55 +0000
From: Pavel Machek <pavel@suse.cz>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jeff Garzik <garzik@havoc.gtf.org>, arjan@fenrus.demon.nl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020205142154.D37@toy.ucw.cz>
In-Reply-To: <20020201144751.A32553@havoc.gtf.org> <Pine.LNX.4.33L.0202021339090.17850-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33L.0202021339090.17850-100000@imladris.surriel.com>; from riel@conectiva.com.br on Sat, Feb 02, 2002 at 01:39:34PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > the biggest reason for this is that we *suck* at readahead for mmap....
> >
> > Is there not also fault overhead and similar issues related to mmap(2)
> > in general, that are not present with read(2)/write(2)?
> 
> If a fault is more expensive than a system call, we're doing
> something wrong in the page fault path ;)

You can read 128K at a time, but you can't fault 128K...
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

