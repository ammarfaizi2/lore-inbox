Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130089AbRBVQVq>; Thu, 22 Feb 2001 11:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130130AbRBVQVg>; Thu, 22 Feb 2001 11:21:36 -0500
Received: from river.it.gvsu.edu ([148.61.1.16]:44994 "EHLO river.it.gvsu.edu")
	by vger.kernel.org with ESMTP id <S130089AbRBVQVZ>;
	Thu, 22 Feb 2001 11:21:25 -0500
Message-ID: <3A953C80.9030609@lycosmail.com>
Date: Thu, 22 Feb 2001 11:21:20 -0500
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-ac6 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: linux ac20 patch got error:
In-Reply-To: <Pine.LNX.4.33.0102220543240.1500-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:

 > On Wed, 21 Feb 2001, Adam Schrotenboer wrote:
 >
 >> A rather incomprehensible message, so let's flesh this out a bit.
 >>
 >> Basically the problem occurs when patching linux/fs/reiserfs/namei.c It
 >> can't find it, presumably due to an error in 2.4.1, where it appears to
 >> me that reiserfs/ is located off of linux/ not linux/fs/. Simple to fix,
 >> I guess, though this would appear to mean that Linus made a mistake w/
 >> 2.4.1 (plz correct me if I'm wrong), though it could also be said that
 >> this means that Alan diff'd the wrong tree (basically a fixed tree in re
 >> reiserfs/)
 >
 >
 > A third possibility: an elf/gremlin munged your tree for grins ;-)

maybe I coffed. 8-)

 >
 > ac20 went in clean here.
 >
 > 	-Mike

Granted that this is possible, yet how likely is it that two people
would come up with the same problem, when they don't even know each
other. 2nd, this was a fresh tree, i.e. 2.4.0 from tar.bz2, patch to
2.4.1, then patch to 2.4.1-ac20, therefore there likely must be
something else. Maybe a similarly corrupted (shouldn't be possible w/
bz2, let alone gz) 2.4.1 patch, or some such. Still, given that it was a
d/l from zeus.kernel.org, it should be ok (short of somebody hacking the
server. I rarely check the sigs)

