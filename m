Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132767AbQKXLhE>; Fri, 24 Nov 2000 06:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132768AbQKXLgy>; Fri, 24 Nov 2000 06:36:54 -0500
Received: from t1o314p206.teliauk.com ([195.12.238.206]:14853 "EHLO oakley.isz")
        by vger.kernel.org with ESMTP id <S132767AbQKXLgh>;
        Fri, 24 Nov 2000 06:36:37 -0500
Date: Fri, 24 Nov 2000 11:06:16 +0000 (GMT)
From: Mike Ricketts <mike@earth.li>
Reply-To: Mike Ricketts <rickettm@ox.compsoc.net>
To: Ion Badulescu <ionut@cs.columbia.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <Pine.LNX.4.21.0011240025570.16450-100000@age.cs.columbia.edu>
Message-ID: <Pine.LNX.4.10.10011241101410.790-100000@oakley.isz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000, Ion Badulescu wrote:

> So I'm asking the same question, to all those who have seen unexplained
> filesystem corruption with 2.4.0: are you using IDE drives? If the answer
> is yes, can you check the logs and see if, at *any* point before the
> corruption occurred, the IDE driver choked and disabled DMA for *any* of
> your disks?

I have both IDE and SCSI drives in my machine, but have only seen
corruption on the SCSI drives.  That doesn't mean that the problem only
exists on the SCSI drives - they IDE ones are not frequently written to.
I have disabled DMA myself on all my IDE drives because if I enable it,
the IDE driver always chokes the first time they are anything like
hammered (well, it always used to - I haven't actually tried it recently).

-- 
Mike Ricketts <mike@earth.li>               Phone: +44 7968 381810

Humility is the first of the virtues -- for other people.
		-- Oliver Wendell Holmes

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
