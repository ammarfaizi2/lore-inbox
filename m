Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131806AbRDMU4Z>; Fri, 13 Apr 2001 16:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131809AbRDMU4P>; Fri, 13 Apr 2001 16:56:15 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:43642 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S131806AbRDMU4H>; Fri, 13 Apr 2001 16:56:07 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: lk@tantalophile.demon.co.uk, phillips@nl.linux.org
Subject: Re: [RFC] Ext2 Directory Index - File Structure
Cc: acahalan@cs.uml.edu, linux-kernel@vger.kernel.org
Message-Id: <20010413205602Z92226-31792+12@humbolt.nl.linux.org>
Date: Fri, 13 Apr 2001 22:55:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Daniel Phillips wrote:
> > ls already can't handle the directories I'm working with on a regular
> > basis.  It's broken and needs to be fixed.  A merge sort using log n
> > temporary files is not hard to write.
> 
> ls -U | sort
> 
> should do the trick.
 
Um, yep.  Now ls should do that itself instead of giving up with an error.
--
Daniel

