Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261300AbSJCTLM>; Thu, 3 Oct 2002 15:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbSJCTLM>; Thu, 3 Oct 2002 15:11:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:54477 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261300AbSJCTLL>; Thu, 3 Oct 2002 15:11:11 -0400
Date: Thu, 3 Oct 2002 16:16:25 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Christoph Hellwig <hch@infradead.org>
Cc: Alan Cox <alan@redhat.com>, Greg Ungerer <gerg@snapgear.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.40-ac1
In-Reply-To: <20021003155122.A20437@infradead.org>
Message-ID: <Pine.LNX.4.44L.0210031614030.1909-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2002, Christoph Hellwig wrote:
> On Thu, Oct 03, 2002 at 10:20:03AM -0400, Alan Cox wrote:

> > The two are so different I think that keeping it seperate is actually the
> > right idea personally.
>
> Did you actually take a look?  Many files are basically the same and other
> are just totally stubbed out in nommu.

So how about having one mm/ directory with:

1) the common stuff
2) the MMU stuff
3) the NOMMU stuff

... and some magic in Makefile to select which .c files to
compile ?

That should keep code duplication to a minimum.

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

