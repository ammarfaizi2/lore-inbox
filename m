Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRCHPix>; Thu, 8 Mar 2001 10:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRCHPin>; Thu, 8 Mar 2001 10:38:43 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:3850 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129078AbRCHPi1>; Thu, 8 Mar 2001 10:38:27 -0500
Date: Thu, 08 Mar 2001 10:33:40 -0500
From: Chris Mason <mason@suse.com>
To: zole@jblinux.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-acX and reiserfs
Message-ID: <475580000.984065620@tiny>
In-Reply-To: <61183.213.142.77.204.984044211.squirrel@diamond.no>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, March 08, 2001 08:36:51 AM -0100 "zole@jblinux.net"
<zole@jblinux.net> wrote:

> 
> I'm 99.9% certain that those patches referred to have been merged with the
> latest 2.4.2-acX, but just to make it 100% certain I'm asking this
> question. At www.namesys.com, the reiserfs website, I read:
> "Latest patch for linux-2.4.2 contains fixes for tail conversion bug,
> preallocated block leakage, object id sharing problem, dir fsync bug and
> other minor fixes/improvements."
> Have _all_ those fixes gone into the latest ac-patch? (I saw references to
> "tail conversion fixes" and "dir fsync bug" in Alan's Changelog, but I
> didn't find all of them so I'm not sure. :-)
> The reason of why I'm wondering is that I've been having serious trouble
> with reiserfs, and when I'm going for a new fresh installation I want to
> be 100% sure that all fixes have been merged.
> So I would really appreciate a confirmation that all fixes have been
> merged, so I won't have to worry. :-)

Alan has been really proactive at taking the critical bug fixes.  He has
all the tail conversion fixes and the dir fsync bug (as does linus).  So,
if you are having huge problems with reiserfs on the latest ac series,
please let us know.

The big reiserfs patch that was posted last week wasn't as clean as it
could have been, it has been broken up into smaller units, and the less
important stuff removed.  They'll probably post it again this week.

-chris


