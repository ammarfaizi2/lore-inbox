Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270717AbTGNRDC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270713AbTGNRBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:01:20 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:17891 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270699AbTGNRAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:00:08 -0400
Date: Mon, 14 Jul 2003 14:12:30 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Christoph Hellwig <hch@lst.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com, Christoph Hellwig <hch@infradead.org>,
       Jan Kara <jack@suse.cz>
Subject: Re: -- END OF BLOCK -- (fwd)
In-Reply-To: <20030714143613.GA9349@lst.de>
Message-ID: <Pine.LNX.4.55L.0307141411400.8994@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307141007560.18257@freak.distro.conectiva>
 <20030714143613.GA9349@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jul 2003, Christoph Hellwig wrote:

> On Mon, Jul 14, 2003 at 10:08:02AM -0300, Marcelo Tosatti wrote:
> > The quota code you have in -ac is new Jan Kara's stuff (which supports
> > both formats, etc) plus the ext3 deadlock avoidance and the compat stuff ?
> >
> > Christoph, for what reason have you removed the ext3 deadlock avoidance
> > patches? And also, what else have you changed wrt originals Jan code ?
>
> Umm, I didn't not remove anything.  I backported Jan's code from 2.5
> long ago and resynched with 2.5 from time to time.  I sent this code
> to Alan and Andrea for -aa and -ac and now sent it to you with the
> changes you requested (make the old quota format and userland ABI
> compiled in unconditionally.)
>
> Now it seems Alan merged other stuff without telling the person
> who send him the original patch, thus -ac seems to have code the
> XFS tree and -aa don't have.
>
> I've now extracted the ext3 quota changes from -ac for you.  Note
> that their only relation of them to the new quota code is that
> the patch is ontop of it and thus takes it into account, the problem
> is an old one.
>
> Here's the patch, probably the last 2.4 patch from me if we really
> want to play the hot potatoe game.
>
> > Lets have -pre6 soon to fix up this mess (which is causing DEADLOCKS), ok?
>
> s/cause/not fix existing/
>
>
> p.s. yes, the patch is more ugly than anything I'd usually submit.
> but it's not mine and I don't have any interest in it.  merge it asis
> or clean it up yourself - I don't care anymore.

Thanks a lot for the patch. Its applied.
