Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270674AbTGNRc2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270765AbTGNRc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:32:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2319 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S270674AbTGNR02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:26:28 -0400
Date: Mon, 14 Jul 2003 19:41:15 +0200
From: Jan Kara <jack@suse.cz>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: -- END OF BLOCK --
Message-ID: <20030714174115.GA8620@atrey.karlin.mff.cuni.cz>
References: <200307141239.h6ECdqXP002766@hraefn.swansea.linux.org.uk> <Pine.LNX.4.55L.0307140947210.18257@freak.distro.conectiva> <1058187405.606.65.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.55L.0307141000150.18257@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307141000150.18257@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 14 Jul 2003, Alan Cox wrote:
> 
> > On Llu, 2003-07-14 at 13:50, Marcelo Tosatti wrote:
> > > > I've resynched -ac to the quota code in pre5 and added the automatic
> > > > quota loader on top again.
> > >
> > > And the deadlock avoidance patches too right?
> > >
> > > Would you mind sending me the automatic quota loader diff and the deadlock
> > > avoidance diff ?
> >
> > The merge is non trivial. I'll let Christoph sort the mess out since I don't
> > have time to waste on it, and the old -ac quota code works perfectly well for
> > me.
> 
> Okay.
> 
> The quota code you have in -ac is new Jan Kara's stuff (which supports
> both formats, etc) plus the ext3 deadlock avoidance and the compat stuff ?
  The deadlock avoidance, quota module autoload etc. are patches which
are not existing for a long time (two weeks or so) and they were merged
just into the last 2.5 kernel so it's not Christophs fault he didn't
send them to you. Actually I just wanted to send them to you myself today...
Anyway now it seems everything is sorted out.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
