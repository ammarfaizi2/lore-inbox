Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTHZRXD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 13:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTHZRXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 13:23:03 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:21006
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262577AbTHZRXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 13:23:00 -0400
Date: Tue, 26 Aug 2003 10:22:57 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: md: bug in file raid5.c, line 540 was: Re: Linux 2.4.22-rc1
Message-ID: <20030826172257.GE16831@matchmail.com>
Mail-Followup-To: Lars Marowsky-Bree <lmb@suse.de>,
	Neil Brown <neilb@cse.unsw.edu.au>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0308051543130.12501-100000@logos.cnet> <20030819202629.GA4083@matchmail.com> <20030819210913.GC4083@matchmail.com> <16197.43294.828878.586018@gargle.gargle.HOWL> <20030822155039.GA6980@marowsky-bree.de> <20030822212659.GK1040@matchmail.com> <20030823152826.GB9239@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823152826.GB9239@marowsky-bree.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 05:28:26PM +0200, Lars Marowsky-Bree wrote:
> On 2003-08-22T14:26:59,
>    Mike Fedyk <mfedyk@matchmail.com> said:
> 
> > > I fixed that for multipath in 2.4 too, but I can't get around to clean
> > > up the patchset *sigh*
> > Then send the patch to someone who can...
> 
> I've repeatedly announced the updated patches at
> ftp://ftp.suse.com/pub/people/lmb/md-mp/kernel/ in the past (though the
> URL has varied slightly), so feel free to pick them up.
> 
> > Has anyone attempted to create a testbed for md? 
> 
> I've done that for the multipath module. I've put my mp-test.sh at
> ftp://ftp.suse.com/pub/people/lmb/md-mp/mp-test.sh, too. It comes
> without any warranty or documentation besides the comments in the
> script though ;-)
> 

Is there any way to get it working on one partition, or does it require at
least two backing store block (an actual physical disk) devices that a bunch
of loop devices point to?  (I'm thinking of the raid[15] case).

