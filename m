Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbUCKQ7S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 11:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUCKQ7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 11:59:17 -0500
Received: from gprs40-186.eurotel.cz ([160.218.40.186]:20937 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261535AbUCKQ7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 11:59:14 -0500
Date: Thu, 11 Mar 2004 17:58:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.4
Message-ID: <20040311165853.GA381@elf.ucw.cz>
References: <Pine.LNX.4.58.0403101924510.3693@ppc970.osdl.org> <200403110849.43527.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403110849.43527.lkml@kcore.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> On Thursday 11 March 2004 04:28, Linus Torvalds wrote:
> > A few small fixes since -rc3, most notably an OHCI bug that would corrupt
> > memory and seems to have been the reason for the "Bad page flags" bug at
> > least on ppc64 (it's not been reported on x86, as far as I know, but I
> > don't see why the corruption couldn't have happened there too).
> >
> > The full changelog from 2.6.3 is on the ftp-sites along with the patches
> > and tar-balls, and the BK trees have been updated.

> Just upgraded from 2.6.2 to 2.6.4. The new -mregparm=3 support, how likely is 
> it to totally break one's system? I'm not really in the mood to trash boxes 
> today ;p

There were some problems with that, but they should be fixed. If you
are using binary-only drivers, stay away from that.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
