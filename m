Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271748AbRHURUj>; Tue, 21 Aug 2001 13:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271751AbRHURUa>; Tue, 21 Aug 2001 13:20:30 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:33796 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271748AbRHURUU>; Tue, 21 Aug 2001 13:20:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Sven Heinicke <sven@research.nj.nec.com>
Subject: Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on 7899P)
Date: Tue, 21 Aug 2001 19:26:58 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010820230909.A28422@oisec.net> <20010821150202Z16034-32383+699@humbolt.nl.linux.org> <15234.37073.974320.621770@abasin.nj.nec.com>
In-Reply-To: <15234.37073.974320.621770@abasin.nj.nec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010821172029Z16065-32384+285@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 21, 2001 06:48 pm, Sven Heinicke wrote:
> Yes, highmem was on, the stystem got 4G of memory.  I turned off
> highmem and got no messages apart from one:
> 
> Aug 21 07:29:19 ps1 kernel: (scsi0:A:0:0): Locking max tag count at 64
> 
> which I was getting before.
>
> Disk access is faster then before but still slower then the IDE
> drive.  Any ideas?

Two separate problems, I think.  I don't know anything about the aic7xxx 
driver but I can take a look at the highmem problem.  First, can you try
it with highmem enabled, on a recent -ac kernel, say 2.4.8-ac7.

--
Daniel
