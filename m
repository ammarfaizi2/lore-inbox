Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTLDFpO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 00:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbTLDFpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 00:45:14 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:45577 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262564AbTLDFpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 00:45:07 -0500
Date: Thu, 4 Dec 2003 06:41:12 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Tim Connors <tconnors+linuxkernel1070509204@astro.swin.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
Message-ID: <20031204054112.GC11325@alpha.home.local>
References: <20031202135423.GB13388@conectiva.com.br> <Pine.LNX.4.58.0312021508470.21855@moje.vabo.cz> <bql9kk$iq1$1@gatekeeper.tmr.com> <20031204012420.GE4420@pegasys.ws> <20031204014743.GF29119@mis-mike-wstn.matchmail.com> <slrn-0.9.7.4-10320-18132-200312041440-tc@hexane.ssi.swin.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrn-0.9.7.4-10320-18132-200312041440-tc@hexane.ssi.swin.edu.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Thu, Dec 04, 2003 at 02:45:13PM +1100, Tim Connors wrote:
> > What about ext3?  I tend to prefer ext3 since I know how it works more than
> > the others, and it puts data integrity ahead of performance, which is the
> > way things should be (TM).
> 
> Is it true that JFS still doesn't use a /lost+found?
<...>

> I have had plenty of problems with it. One I can think of is under
> debian, after your $RANDOM mounts, it doesn't manage to do the
> automatic forced fsck, so none of the filesystems get mounted. It
> tries to stumble along without having mounted /usr. I have to reboot,
> log in single user, and manually fsck. I don't know whther this is a
> fsck.jfs or a debian deficiency.

I recently had a very bad experience on my notebook with ext3 and fsck. It
had not checked the disk for 180 days, and started it... I can now estimate
about 60 files I lost in /usr (most of them in /usr/bin), but I regularly
discover new missing ones. Since this notebook has experience lots of
crashes, I think that the FS already was in bad situation, but these files
were still OK for me just before I shut it down. I cannot imagine not
noticing a "make: command not found" after a day of compilation. So I
stuffed some missing files in it again and it's OK now. I really don't
know what happened. Perhaps I fscked during a solar flare :-)

Cheers
Willy

