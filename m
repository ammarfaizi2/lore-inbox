Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266020AbSKZCTL>; Mon, 25 Nov 2002 21:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266043AbSKZCTL>; Mon, 25 Nov 2002 21:19:11 -0500
Received: from almesberger.net ([63.105.73.239]:13833 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S266020AbSKZCTL>; Mon, 25 Nov 2002 21:19:11 -0500
Date: Mon, 25 Nov 2002 23:26:10 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: Module Refcount & Stuff mini-FAQ
Message-ID: <20021125232610.A22825@almesberger.net>
References: <20021125033906.B1549@almesberger.net> <20021125234442.07F392C26E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021125234442.07F392C26E@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Nov 26, 2002 at 09:43:06AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Ah, see other thread

Argh, there are only about a hundred threads on modules ;-)

> (weren't you at the kernel summit?).

Yes, but I hadn't paid much attention to modules before, so I only
understood about half of what you said, sorry. It was interesting
to learn that there were actually so many problems, though :-)

> There's currently no way to abort if you've exposed interfaces and then
> something fails ("don't do that" is great except noone knows that, and
> it's not always possible or nice)

Hmm, if "expose interface" == "publish symbol", why can't you simply
defer publishing until after initialization completes ? If "expose
interface" == "register something somewhere", then this has to be
undone anyway. Or am I overlooking something here ?

Thanks,
- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
