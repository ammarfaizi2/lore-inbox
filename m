Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130850AbRBAQQ2>; Thu, 1 Feb 2001 11:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130872AbRBAQQS>; Thu, 1 Feb 2001 11:16:18 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:24077 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S130850AbRBAQQL>; Thu, 1 Feb 2001 11:16:11 -0500
Date: Thu, 01 Feb 2001 11:16:04 -0500
From: Chris Mason <mason@suse.com>
To: David Ford <david@linux.com>, LKML <linux-kernel@vger.kernel.org>,
        reiserfs-list@namesys.com
Subject: Re: VM brokenness, possibly related to reiserfs
Message-ID: <371620000.981044164@tiny>
In-Reply-To: <3A790A16.C964877@linux.com>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, January 31, 2001 11:02:46 PM -0800 David Ford <david@linux.com> wrote:

> (Chris, changing JOURNAL_MAX_BATCH from 900 to 100 didn't affect
> anything).
> 
> Ok, having approached this slightly more intelligently here are [better]
> results.
> 
> The dumps are large so they are located at http://stuph.org/VM/.  Here's
> the story.  

Sorry, can't seem to resolve stuph.org.  What is kreiserfsd doing during when the system is waiting for more ram?  With JOURNAL_MAX_BATCH set to 100, kreiserfsd will end up responsible for sending log blocks/metadata to disk and freeing the pinned buffers.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
