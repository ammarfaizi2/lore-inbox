Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbSI0HTi>; Fri, 27 Sep 2002 03:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261438AbSI0HTi>; Fri, 27 Sep 2002 03:19:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19073 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261413AbSI0HTh>;
	Fri, 27 Sep 2002 03:19:37 -0400
Date: Fri, 27 Sep 2002 09:24:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Matthew Jacob <mjacob@feral.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file transfers
Message-ID: <20020927072441.GT5646@suse.de>
References: <20020927065610.GQ5646@suse.de> <Pine.BSF.4.21.0209270018360.18029-100000@beppo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.21.0209270018360.18029-100000@beppo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27 2002, Matthew Jacob wrote:
> > 
> > So I think the 'more tags the better!' belief is very much bogus, at
> > least for the common case.
> 
> Well, that's one theory.

Numbers talk, theory spinning walks

Both Andrew and I did latency numbers for even small depths of tagging,
and the result was not pretty. Sure this is just your regular plaino
SCSI drives, however that's also what I care most about. People with
big-ass hardware tend to find a way to tweak them as well, I'd like the
typical systems to run fine out of the box though.

-- 
Jens Axboe

