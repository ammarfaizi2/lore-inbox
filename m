Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVAYVXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVAYVXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbVAYVUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:20:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33664 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262131AbVAYVR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:17:29 -0500
Date: Tue, 25 Jan 2005 21:17:24 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Bill Davidsen <davidsen@tmr.com>,
       Valdis.Kletnieks@vt.edu, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050125211723.GE8859@parcelfarce.linux.theplanet.co.uk>
References: <1106157152.6310.171.camel@laptopd505.fenrus.org> <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu> <41F6604B.4090905@tmr.com> <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org> <41F6816D.1020306@tmr.com> <41F68975.8010405@comcast.net> <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org> <41F691D6.8040803@comcast.net> <Pine.LNX.4.58.0501251054400.2342@ppc970.osdl.org> <41F6A5F8.5030100@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F6A5F8.5030100@comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 03:03:04PM -0500, John Richard Moser wrote:
> > and combining them has _zero_ advantages (whatever bug the combined patch
> > fix _will_ be fixed by the series of individual patches too - even if the
> > splitting was buggy in some respect, you are pretty much guaranteed of
> > this, since the bug you were trying to fix is the _one_ thing you are
> > really testing for). 
> 
> Lots of work to split up a patch though.

Exactly.  And since that's a prerequisite for any meaningful review,
some equivalent of that work will have to be done at some point.
The only question is who will be doing that work - proponents of patch
or reviewers?

Look at it that way: when you are submitting a paper for publication,
it's your responsibility to get it into form that would allow review.

Sending a lump of something that might, given considerable efforts, be
massaged into readable and understandable text is not going to fly.
And doing that with "it's a lot of work [so could reviewers please do
that work themselves and spare me the efforts]" as rationale...
