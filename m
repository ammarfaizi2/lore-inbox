Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131928AbQKXLjp>; Fri, 24 Nov 2000 06:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132768AbQKXLje>; Fri, 24 Nov 2000 06:39:34 -0500
Received: from 213-123-74-93.btconnect.com ([213.123.74.93]:62468 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S131928AbQKXLjW>;
        Fri, 24 Nov 2000 06:39:22 -0500
Date: Fri, 24 Nov 2000 11:11:09 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Mike Ricketts <rickettm@ox.compsoc.net>
cc: Ion Badulescu <ionut@cs.columbia.edu>, linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <Pine.LNX.4.10.10011241101410.790-100000@oakley.isz>
Message-ID: <Pine.LNX.4.21.0011241110500.1361-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen ext2 filesystem corruption both on SCSI and IDE drives.

Tigran

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
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
