Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbTGOFbf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 01:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTGOFbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 01:31:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48528 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262584AbTGOFbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 01:31:32 -0400
Date: Tue, 15 Jul 2003 07:46:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030715054621.GE833@suse.de>
References: <1057932804.13313.58.camel@tiny.suse.com> <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com> <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random> <20030714054918.GD843@suse.de> <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva> <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de> <1058213348.13313.274.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058213348.13313.274.camel@tiny.suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14 2003, Chris Mason wrote:
> On Mon, 2003-07-14 at 15:51, Jens Axboe wrote:
> 
> > Some initial results with the attached patch, I'll try and do some more
> > fine grained tomorrow. Base kernel was 2.4.22-pre5 (obviously), drive
> > tested is a SCSI drive (on aic7xxx, tcq fixed at 4), fs is ext3. I would
> > have done ide testing actually, but the drive in that machine appears to
> > have gone dead. I'll pop in a new one tomorrow and test on that too.
> > 
> 
> Thanks Jens, the results so far are very interesting (although I'm
> curious to hear how 2.4.21 did).

Hmm good point, I'll make a run with that as well.

-- 
Jens Axboe

