Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154340AbQDJWZy>; Mon, 10 Apr 2000 18:25:54 -0400
Received: by vger.rutgers.edu id <S154369AbQDJWZg>; Mon, 10 Apr 2000 18:25:36 -0400
Received: from dukat.scot.redhat.com ([195.89.149.246]:2066 "EHLO dukat.scot.redhat.com") by vger.rutgers.edu with ESMTP id <S154423AbQDJWYu>; Mon, 10 Apr 2000 18:24:50 -0400
Date: Mon, 10 Apr 2000 23:21:49 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kanoj Sarcar <kanoj@google.engr.sgi.com>, Manfred Spraul <manfreds@colorfullife.com>, linux-kernel@vger.rutgers.edu, linux-mm@kvack.org, torvalds@transmeta.com, davem@redhat.com
Subject: Re: zap_page_range(): TLB flush race
Message-ID: <20000410232149.M17648@redhat.com>
References: <200004082331.QAA78522@google.engr.sgi.com> <E12e4mo-0003Pn-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E12e4mo-0003Pn-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Apr 09, 2000 at 12:37:05AM +0100
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

On Sun, Apr 09, 2000 at 12:37:05AM +0100, Alan Cox wrote:
> 
> Basically establish_pte() has to be architecture specific, as some processors
> need different orders either to avoid races or to handle cpu specific
> limitations.

What exactly do different architectures need which set_pte() doesn't 
already allow them to do magic in?  

--Stephen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
