Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279993AbRJ3QNx>; Tue, 30 Oct 2001 11:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279997AbRJ3QNn>; Tue, 30 Oct 2001 11:13:43 -0500
Received: from denise.shiny.it ([194.20.232.1]:16049 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S279993AbRJ3QNd>;
	Tue, 30 Oct 2001 11:13:33 -0500
Message-ID: <XFMail.20011030171353.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.33L.0110301324410.2963-100000@imladris.surriel.com>
Date: Tue, 30 Oct 2001 17:13:53 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: please revert bogus patch to vmscan.c
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> But of course going from page flush to the mm flush is fine from my part
>> too. As Linus noted a few days ago during swapout we're going to block
>> and reschedule all the time, so the range flush is going to be a noop in
> 
> Only on architectures where the TLB (or equivalent) is
> small and only capable of holding entries for one address
> space at a time.
> 
> It's simply not true on eg PPC.

#ifdef ?


Bye.

