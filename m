Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130531AbRCIPLg>; Fri, 9 Mar 2001 10:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130529AbRCIPL0>; Fri, 9 Mar 2001 10:11:26 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:64244 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130528AbRCIPLP>; Fri, 9 Mar 2001 10:11:15 -0500
Date: Fri, 9 Mar 2001 19:22:57 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] documentation mm.h + swap.h
In-Reply-To: <5.0.2.1.2.20010309003257.00abeac0@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.33.0103091922460.2283-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2001, Anton Altaparmakov wrote:
> At 21:10 08/03/2001, Rik van Riel wrote:
> >+ * There is also a hash table mapping (inode,offset) to the page
> >+ * in memory if present. The lists for this hash table use the fields
> >+ * page->next_hash and page->pprev_hash.
>
> Shouldn't (inode,offset) be (inode,index), or possibly (mapping,index)?

> And here, too?

Indeed, thanks.

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

