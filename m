Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278090AbRJKEeP>; Thu, 11 Oct 2001 00:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278092AbRJKEeF>; Thu, 11 Oct 2001 00:34:05 -0400
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:61921 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S278090AbRJKEdu>; Thu, 11 Oct 2001 00:33:50 -0400
Date: Thu, 11 Oct 2001 00:34:20 -0400 (EDT)
From: "Daniel T. Chen" <crimsun@email.unc.edu>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-ac11
In-Reply-To: <20011011042228.A10133@emma1.emma.line.org>
Message-ID: <Pine.A41.4.21L1.0110110025590.37700-100000@login3.isis.unc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001, Matthias Andree wrote:

> > 2.4.10-ac11
> > o	Further VM tuning				(Rik van Riel)
> 
> Short version: Kicks ass!

Yep, same as the results I've been seeing with Rik's patches beginning
from -ac9. Several of my machines run lots of simultaneous compiles using
both gcc and javac, and on a machine with 64megs RAM I've had great
results (much less sluggish) with Rik's tuning.

As a side note, -ac11 only contains Rik's eatcache portion; you may wish
to grab his hogstop diff against -ac11.

> However, one thing strikes me on boot: ext3fs claims it's 0.9.6, while
> the ext3 web site tells us about 0.9.10. What's going on with 2.4.x-ac
> ext3fs? Should I be concerned?

I'm using ext3-0.9.12, which Andrew Morton posted as
http://www.zip.com.au/~akpm/ext3-0.9.12_for_2.4.10-ac9 a few days ago
(note: it's unofficial, which is why it's not linked on the main page). It
applied with only tiny fuzz against -ac11. The last official patch against
the -ac tree was against 2.4.9-ac9 (0.9.9), though Robert Love did put
together a patch that compiles relatively cleanly with only 1 trivial
reject against the later .10-ac series.

---
Dan Chen                 crimsun@email.unc.edu
GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc

