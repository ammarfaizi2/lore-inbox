Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbSI0MuH>; Fri, 27 Sep 2002 08:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbSI0MuH>; Fri, 27 Sep 2002 08:50:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43452 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261607AbSI0MuF>;
	Fri, 27 Sep 2002 08:50:05 -0400
Date: Fri, 27 Sep 2002 14:54:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Matthew Jacob <mjacob@feral.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file transfers
Message-ID: <20020927125452.GB23468@suse.de>
References: <20020927102503.GA15101@suse.de> <Pine.BSF.4.21.0209270510350.20512-100000@beppo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.21.0209270510350.20512-100000@beppo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27 2002, Matthew Jacob wrote:
> 
> [ .. all sorts of nice discussion, but not on our argument point ]
> > 
> > Agrh. Who's saying 'fix' the hba driver? Either I'm not expressing
> > myself very clearly, or you are simply not reading what I write.
> 
> I (foolishly) leapt in when you said "253 is 'over the top'". You seemed
> to imply that the aic7xxx driver was at fault and should be limiting the
> amount it is sending out. My (mostly) only beef with what you've written
> is with that implication- mainly as "don't send so many damned commands
> if you think they're too many". If the finger pointing at aic7xx is not
> what you're implying, then this has been a waste of email bandwidth-
> sorry.

It's not aimed at any specific hba driver, it could be any. 253 would be
over the top for any of them, it just so happens that aic7xxx has this
as the default :-)

So while it is definitely not the aic7xxx driver doing the starvation
(it's the device), the aic7xxx driver is (_in my oppinion) somewhat at
fault for setting it so high _as a default_.

Hopefully that's the end of this thread :)

-- 
Jens Axboe

