Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136567AbREAErw>; Tue, 1 May 2001 00:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136570AbREAEre>; Tue, 1 May 2001 00:47:34 -0400
Received: from cs.columbia.edu ([128.59.16.20]:25822 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S136567AbREAEra>;
	Tue, 1 May 2001 00:47:30 -0400
Date: Mon, 30 Apr 2001 21:47:26 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19 locks up on SMP
In-Reply-To: <Pine.LNX.4.33.0104301255020.12259-100000@age.cs.columbia.edu>
Message-ID: <Pine.LNX.4.33.0104302141510.12259-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, Ion Badulescu wrote:

> Ok, so onto the binary search through the 2.2.19pre series...

I think it started in 2.2.19pre10. I can reproduce the hang on pre10, 
quite easily, but I couldn't reproduce it on pre5, pre7 and pre9. I'll try 
a few other pre versions, just to make sure.

One of the things that are different between pre10 and the others is NFS:
the client is broken in all versions except pre10. I'm not sure how much 
it matters, since I wasn't pounding on NFS. Anyway, that's why I want to 
try a few other kernels -- maybe it does matter after all.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

