Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268896AbRIDUHP>; Tue, 4 Sep 2001 16:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268899AbRIDUHF>; Tue, 4 Sep 2001 16:07:05 -0400
Received: from [209.10.41.242] ([209.10.41.242]:54183 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S268896AbRIDUGu>;
	Tue, 4 Sep 2001 16:06:50 -0400
Date: Tue, 4 Sep 2001 15:36:02 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010904215449.S699@athlon.random>
Message-ID: <Pine.LNX.4.21.0109041534281.2112-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Sep 2001, Andrea Arcangeli wrote:

> On Tue, Sep 04, 2001 at 01:54:27PM -0400, Jan Harkes wrote:
> > Now for the past _9_ stable kernel releases, page aging hasn't worked
> > at all!! Nobody seems to even have bothered to check. I send in a patch
> 
> All I can say is that I hope you will get your problem fixed with one of
> the next -aa, I incidentally started working on it yesterday. So far
> it's a one thousand diff very far from compiling, so it will grow
> further, but it shouldn't take too long to finish the rewrite. Once
> finished the benchmarks and the reproducible 2.4 deadlocks will tell me
> if I'm right.

Andrea, 

Could you please describe how you're trying to fix the "anon pages not
being added to the active list at do_no_page()" problem Jan described ?

Thanks!

