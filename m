Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271714AbRHUPCQ>; Tue, 21 Aug 2001 11:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271715AbRHUPCG>; Tue, 21 Aug 2001 11:02:06 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:9747 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271714AbRHUPBz>; Tue, 21 Aug 2001 11:01:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Sven Heinicke <sven@research.nj.nec.com>, linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on 7899P)
Date: Tue, 21 Aug 2001 17:08:34 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20010820230909.A28422@oisec.net> <15233.37122.901333.300620@abasin.nj.nec.com> <15234.29508.488705.826498@abasin.nj.nec.com>
In-Reply-To: <15234.29508.488705.826498@abasin.nj.nec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010821150202Z16034-32383+699@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 21, 2001 04:42 pm, Sven Heinicke wrote:
> Forgive the sin of replying to my own message but Daniel Phillips
> replied to a different message with a patch to somebody getting a
> similar error to mine.  Here is the result:
> 
> Aug 20 15:10:33 ps1 kernel: cation failed (gfp=0x30/1). 
> Aug 20 15:10:33 ps1 kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x30/1). 
> Aug 20 15:10:46 ps1 last message repeated 327 times 
> Aug 20 15:10:47 ps1 kernel: cation failed (gfp=0x30/1). 
> Aug 20 15:10:47 ps1 kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x30/1). 
> Aug 20 15:10:56 ps1 last message repeated 294 times 

Are you using highmem?  Could you try it with highmem configged off?

--
Daniel
