Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbTBQCTJ>; Sun, 16 Feb 2003 21:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbTBQCTJ>; Sun, 16 Feb 2003 21:19:09 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:18844 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S265754AbTBQCTH>; Sun, 16 Feb 2003 21:19:07 -0500
Date: Sun, 16 Feb 2003 21:28:59 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
Message-ID: <20030217022858.GA25539@delft.aura.cs.cmu.edu>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0302141751220.988-100000@blue1.dev.mcafeelabs.com> <Pine.LNX.4.44.0302151202020.11840-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302151202020.11840-100000@home.transmeta.com>
User-Agent: Mutt/1.5.3i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 12:08:10PM -0800, Linus Torvalds wrote:
> it could. It still uses multiple allocations, doing a _separate_
> allocation for the small "pipe_inode_info" instead of doing the embedding 
> trick.

I believe that is because of named pipes. These are sharing the inode
with the filesystem in which the named pipe is stored.

Jan
