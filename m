Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131339AbRCHM2c>; Thu, 8 Mar 2001 07:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131340AbRCHM2W>; Thu, 8 Mar 2001 07:28:22 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:55027 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131339AbRCHM2S>; Thu, 8 Mar 2001 07:28:18 -0500
Date: Thu, 8 Mar 2001 09:25:55 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Andrew Morton <andrewm@uow.edu.au>, <linux-kernel@vger.kernel.org>
Subject: Re: Questions - Re: [PATCH] documentation for mm.h
In-Reply-To: <5.0.2.1.2.20010308110922.00a41a60@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.33.0103080925010.1409-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2001, Anton Altaparmakov wrote:
> At 10:51 08/03/01, Ingo Oeser wrote:
> >On Thu, Mar 08, 2001 at 10:11:50AM +0000, Anton Altaparmakov wrote:
> > > At 22:33 07/03/2001, Rik van Riel wrote:

>  > * A page may belong to an inode's memory mapping. In this case,
>  > * page->mapping is the pointer to the inode, and page->offset is the
>  > * file offset of the page (not necessarily a multiple of PAGE_SIZE).
>
> Surely, if you have to multiply index by PAGE_{CACHE_}SIZE,
> page->offset would be a multiple of PAGE_{CACHE_}SIZE?

Whooops, indeed. This was a piece of old documentation which was
200 lines down for inexplicable reasons. It's been corrected now.

thanks,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

