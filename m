Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279337AbRJZVxn>; Fri, 26 Oct 2001 17:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279425AbRJZVxd>; Fri, 26 Oct 2001 17:53:33 -0400
Received: from [194.213.32.137] ([194.213.32.137]:2820 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S279337AbRJZVxX>;
	Fri, 26 Oct 2001 17:53:23 -0400
Date: Fri, 26 Oct 2001 13:25:50 +0200
From: Pavel Machek <pavel@suse.cz>
To: James Sutherland <jas88@cam.ac.uk>
Cc: Jan Kara <jack@suse.cz>, Neil Brown <neilb@cse.unsw.edu.au>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
Message-ID: <20011026132550.A20296@elf.ucw.cz>
In-Reply-To: <20011024171658.B10075@atrey.karlin.mff.cuni.cz> <Pine.SOL.4.33.0110241633000.24809-100000@yellow.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.33.0110241633000.24809-100000@yellow.csi.cam.ac.uk>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> 
> >   But how do you solve the following: mv <dir> <some_other_dir>
> > The parent changes. You need to go through all the subdirs of <dir> and change
> > the TID. This is really hard to get right and to avoid deadlocks
> > and races... At least it seems to me so.
> 
> Provided you are tracking the total size in each directory, it's just a
> matter of subtracting dir's size from the old parent, and adding it to the
> new parent. (With suitable checks beforehand to avoid a result which
> exceeds quota.)

And what about hardlinks?
								Pavel
-- 
STOP THE WAR! Someone killed innocent Americans. That does not give
U.S. right to kill people in Afganistan.


