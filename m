Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKYCwN>; Fri, 24 Nov 2000 21:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129153AbQKYCwD>; Fri, 24 Nov 2000 21:52:03 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:52239
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S129091AbQKYCv7>; Fri, 24 Nov 2000 21:51:59 -0500
Date: Fri, 24 Nov 2000 18:21:39 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Mike Ricketts <rickettm@ox.compsoc.net>
cc: Ion Badulescu <ionut@cs.columbia.edu>, linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <Pine.LNX.4.10.10011241101410.790-100000@oakley.isz>
Message-ID: <Pine.LNX.4.10.10011241738520.7354-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000, Mike Ricketts wrote:

> On Fri, 24 Nov 2000, Ion Badulescu wrote:
> 
> > So I'm asking the same question, to all those who have seen unexplained
> > filesystem corruption with 2.4.0: are you using IDE drives? If the answer
> > is yes, can you check the logs and see if, at *any* point before the
> > corruption occurred, the IDE driver choked and disabled DMA for *any* of
> > your disks?
> 
> I have both IDE and SCSI drives in my machine, but have only seen
> corruption on the SCSI drives.  That doesn't mean that the problem only
> exists on the SCSI drives - they IDE ones are not frequently written to.
> I have disabled DMA myself on all my IDE drives because if I enable it,
> the IDE driver always chokes the first time they are anything like
> hammered (well, it always used to - I haven't actually tried it recently).

This is the kind of data point that is needed.
A possible storage class independent problem.
More important, what was the first kernel you began to notice this
problem.  Next, I need you to enable the DMA engine in ATA to verify that
is happening on both classes.

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
