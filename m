Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270642AbTGNMyO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270657AbTGNMyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:54:08 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:27834 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270623AbTGNMvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:51:05 -0400
Date: Mon, 14 Jul 2003 10:03:23 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, marcelo@conectiva.com,
       Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: -- END OF BLOCK --
In-Reply-To: <1058187405.606.65.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55L.0307141000150.18257@freak.distro.conectiva>
References: <200307141239.h6ECdqXP002766@hraefn.swansea.linux.org.uk> 
 <Pine.LNX.4.55L.0307140947210.18257@freak.distro.conectiva>
 <1058187405.606.65.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jul 2003, Alan Cox wrote:

> On Llu, 2003-07-14 at 13:50, Marcelo Tosatti wrote:
> > > I've resynched -ac to the quota code in pre5 and added the automatic
> > > quota loader on top again.
> >
> > And the deadlock avoidance patches too right?
> >
> > Would you mind sending me the automatic quota loader diff and the deadlock
> > avoidance diff ?
>
> The merge is non trivial. I'll let Christoph sort the mess out since I don't
> have time to waste on it, and the old -ac quota code works perfectly well for
> me.

Okay.

The quota code you have in -ac is new Jan Kara's stuff (which supports
both formats, etc) plus the ext3 deadlock avoidance and the compat stuff ?

Christoph, for what reason have you removed the ext3 deadlock avoidance
patches? And also, what else have you changed wrt originals Jan code ?

Lets have -pre6 soon to fix up this mess (which is causing DEADLOCKS), ok?

