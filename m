Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272010AbRIDQuh>; Tue, 4 Sep 2001 12:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271994AbRIDQu1>; Tue, 4 Sep 2001 12:50:27 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:39433 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272010AbRIDQuQ>; Tue, 4 Sep 2001 12:50:16 -0400
Date: Tue, 4 Sep 2001 12:24:36 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>, riel@conectiva.com.br
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010904112629.A27988@cs.cmu.edu>
Message-ID: <Pine.LNX.4.21.0109041220260.1578-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Sep 2001, Jan Harkes wrote:

> On Mon, Sep 03, 2001 at 11:57:09AM -0300, Marcelo Tosatti wrote:
> > I already have some code which adds a laundry list -- pages being written
> > out (by page_launder()) go to the laundry list, and each page_launder()
> > call will first check for unlocked pages on the laundry list, for then
> > doing the usual page_launder() stuff.
> 
> NO, please don't add another list to fix the symptoms of bad page aging.

Please, read my message again.

The laundry list is not an attempt to fix aging. Its just one way to find
previously cleaned data faster.

You should have created a new thread with subject "Aging is broken". :)

