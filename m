Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268835AbRIDT4F>; Tue, 4 Sep 2001 15:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268570AbRIDTzy>; Tue, 4 Sep 2001 15:55:54 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:16660 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268792AbRIDTzk>; Tue, 4 Sep 2001 15:55:40 -0400
Date: Tue, 4 Sep 2001 21:54:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <20010904215449.S699@athlon.random>
In-Reply-To: <20010904131349.B29711@cs.cmu.edu> <Pine.LNX.4.21.0109041253510.2038-100000@freak.distro.conectiva> <20010904135427.A30503@cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010904135427.A30503@cs.cmu.edu>; from jaharkes@cs.cmu.edu on Tue, Sep 04, 2001 at 01:54:27PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 01:54:27PM -0400, Jan Harkes wrote:
> Now for the past _9_ stable kernel releases, page aging hasn't worked
> at all!! Nobody seems to even have bothered to check. I send in a patch

All I can say is that I hope you will get your problem fixed with one of
the next -aa, I incidentally started working on it yesterday. So far
it's a one thousand diff very far from compiling, so it will grow
further, but it shouldn't take too long to finish the rewrite. Once
finished the benchmarks and the reproducible 2.4 deadlocks will tell me
if I'm right.

Andrea
