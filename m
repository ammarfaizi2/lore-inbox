Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267550AbRGMV2l>; Fri, 13 Jul 2001 17:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267551AbRGMV2c>; Fri, 13 Jul 2001 17:28:32 -0400
Received: from ns.caldera.de ([212.34.180.1]:33766 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S267550AbRGMV2P>;
	Fri, 13 Jul 2001 17:28:15 -0400
Date: Fri, 13 Jul 2001 23:27:39 +0200
Message-Id: <200107132127.f6DLRdc23362@ns.caldera.de>
From: hch@caldera.de (Christoph Hellwig)
To: lyons@gruel.uchicago.edu (Gary Lyons)
Cc: cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: ioctl bug?
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.33.0107131559160.12456-100000@gruel.uchicago.edu>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gary,

In article <Pine.LNX.4.33.0107131559160.12456-100000@gruel.uchicago.edu> you wrote:
> On Sat, 14 Jul 2001, Chris Wedgwood wrote:
>
>>
>> what filesystem? ext2 I assume?
>
> Yes. sorry about leaving that out.

In Al's rewrite of the ext2 directory code that went into 2.4.6-pre
(and 2.4.5-ac) ioctl on dirs got lost.  Just readd the ioctl line
in the fops declaration in dir.c.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
