Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269454AbRHTVi5>; Mon, 20 Aug 2001 17:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269471AbRHTVit>; Mon, 20 Aug 2001 17:38:49 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:7692 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269454AbRHTViT>; Mon, 20 Aug 2001 17:38:19 -0400
Date: Mon, 20 Aug 2001 18:38:12 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Benjamin Redelings I <bredelin@ucla.edu>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: 2.4.8/2.4.9 VM problems
In-Reply-To: <20010820192613Z16342-32383+573@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0108201837460.31410-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2001, Daniel Phillips wrote:

> A similar thing has to be done in filemap_nopage (which will
> take care of mmap pages) and also for any filesystems whose page
> accesses bypass generic_read/write,

Either that, or you fix page_launder() like I explained
to you on IRC yesterday ;)

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

