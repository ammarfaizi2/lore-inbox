Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261657AbSI0H3E>; Fri, 27 Sep 2002 03:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbSI0H3E>; Fri, 27 Sep 2002 03:29:04 -0400
Received: from beppo.feral.com ([192.67.166.79]:61711 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S261657AbSI0H3C>;
	Fri, 27 Sep 2002 03:29:02 -0400
Date: Fri, 27 Sep 2002 00:34:14 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Jens Axboe <axboe@suse.de>
cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file
 transfers
In-Reply-To: <Pine.BSF.4.21.0209270029280.18144-100000@beppo>
Message-ID: <Pine.BSF.4.21.0209270031360.18144-100000@beppo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The issue here is not whether it's appropriate to oversaturate the
'standard' SCSI drive- it isn't- I never suggested it was.

I'd just suggest that it's asinine to criticise an HBA for running up to
reasonable limits when it's the non-toy OS that will do sensible I/O
scheduling. So point your gums elsewhere.



On Fri, 27 Sep 2002, Matthew Jacob wrote:

> 
> 
> On Fri, 27 Sep 2002, Jens Axboe wrote:
> 
> > On Fri, Sep 27 2002, Matthew Jacob wrote:
> > > > 
> > > > So I think the 'more tags the better!' belief is very much bogus, at
> > > > least for the common case.
> > > 
> > > Well, that's one theory.
> > 
> > Numbers talk, theory spinning walks
> > 
> > Both Andrew and I did latency numbers for even small depths of tagging,
> > and the result was not pretty. Sure this is just your regular plaino
> > SCSI drives, however that's also what I care most about. People with
> > big-ass hardware tend to find a way to tweak them as well, I'd like the
> > typical systems to run fine out of the box though.
> > 
> 
> Fair enough. 
> 
> 
> 
> 
> 

