Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbTHVV1G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 17:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbTHVV1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 17:27:05 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:50703
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261160AbTHVV1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 17:27:03 -0400
Date: Fri, 22 Aug 2003 14:26:59 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: md: bug in file raid5.c, line 540 was: Re: Linux 2.4.22-rc1
Message-ID: <20030822212659.GK1040@matchmail.com>
Mail-Followup-To: Lars Marowsky-Bree <lmb@suse.de>,
	Neil Brown <neilb@cse.unsw.edu.au>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0308051543130.12501-100000@logos.cnet> <20030819202629.GA4083@matchmail.com> <20030819210913.GC4083@matchmail.com> <16197.43294.828878.586018@gargle.gargle.HOWL> <20030822155039.GA6980@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822155039.GA6980@marowsky-bree.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 05:50:39PM +0200, Lars Marowsky-Bree wrote:
> On 2003-08-22T15:24:46,
>    Neil Brown <neilb@cse.unsw.edu.au> said:
> 
> > This bug could happen if you try to fail a device that is not active.
> 
> Yes, thats not generally a tested code path in 2.4. On removing the
> BUG() statement, also check that all counters get in/decremented
> correctly, or the next lurking bug will hit you.
> 
> I fixed that for multipath in 2.4 too, but I can't get around to clean
> up the patchset *sigh*

Then send the patch to someone who can...

Has anyone attempted to create a testbed for md?  If not, can you list all
of the states, and state transitions that are legal.  I might be able to
cook something up when I get some time.
