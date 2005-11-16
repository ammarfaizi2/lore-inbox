Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVKPGMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVKPGMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 01:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVKPGMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 01:12:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:8640 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750775AbVKPGMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 01:12:13 -0500
Date: Tue, 15 Nov 2005 22:11:46 -0800
From: Paul Jackson <pj@sgi.com>
To: Luke Yang <luke.adi@gmail.com>
Cc: akpm@osdl.org, greg@kroah.com, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: ADI Blackfin patch for kernel 2.6.14
Message-Id: <20051115221146.4487657f.pj@sgi.com>
In-Reply-To: <489ecd0c0511151944r1552bae3oed5ee88a49795482@mail.gmail.com>
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>
	<20051101165136.GU8009@stusta.de>
	<489ecd0c0511012306w434d75fbs90e1969d82a07922@mail.gmail.com>
	<489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com>
	<20051104230644.GA20625@kroah.com>
	<489ecd0c0511062258k4183d206odefd3baa46bb9a04@mail.gmail.com>
	<20051107165928.GA15586@kroah.com>
	<20051107235035.2bdb00e1.akpm@osdl.org>
	<489ecd0c0511151944r1552bae3oed5ee88a49795482@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke wrote:
> > Cow.  You know that volatile in-kernel is basically always wrong?
> >
>   I really don't know that...  Could you refer me to any document or
> posts talking about it? thank you!

Start with:

  http://lkml.org/lkml/2004/1/6/139

> Date	Tue, 6 Jan 2004 10:02:18 -0800 (PST)
> From	Linus Torvalds <>
> Subject	Re: [PATCH] fix get_jiffies_64 to work on voyager
> 
> [ This is a big rant against using "volatile" on data structures. Feel 
>   free to ignore it, but the fact is, I'm right. You should never EVER use
>   "volatile" on a data structure. ]

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
