Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132186AbRDMWmS>; Fri, 13 Apr 2001 18:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132281AbRDMWmN>; Fri, 13 Apr 2001 18:42:13 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:7949 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132186AbRDMWkl>;
	Fri, 13 Apr 2001 18:40:41 -0400
Date: Sat, 14 Apr 2001 00:40:33 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Daniel Phillips <phillips@nl.linux.org>
Cc: acahalan@cs.uml.edu, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Ext2 Directory Index - File Structure
Message-ID: <20010414004033.A2290@pcep-jamie.cern.ch>
In-Reply-To: <20010413205602Z92226-31792+12@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010413205602Z92226-31792+12@humbolt.nl.linux.org>; from phillips@nl.linux.org on Fri, Apr 13, 2001 at 10:55:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> Jamie Lokier wrote:
> > Daniel Phillips wrote:
> > > ls already can't handle the directories I'm working with on a regular
> > > basis.  It's broken and needs to be fixed.  A merge sort using log n
> > > temporary files is not hard to write.
> > 
> > ls -U | sort
> > 
> > should do the trick.
>  
> Um, yep.  Now ls should do that itself instead of giving up with an error.

Sorting 1 million 30-character strings does not require temporary files
on a machine with > 35 MB anyway, and that can be virtual, so if anyone
cares about ls sorting huge directories I suggest improving the
in-memory sort.

cheers,
-- Jamie
