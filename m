Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSJJX40>; Thu, 10 Oct 2002 19:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262217AbSJJX40>; Thu, 10 Oct 2002 19:56:26 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:44292
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S262215AbSJJX40>; Thu, 10 Oct 2002 19:56:26 -0400
Date: Thu, 10 Oct 2002 17:02:06 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Daniel Phillips <phillips@arcor.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not3.0 - (NUMA))
Message-ID: <20021011000206.GE2673@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Daniel Phillips <phillips@arcor.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Oliver Neukum <oliver@neukum.name>,
	Rob Landley <landley@trommello.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1034021669.26502.19.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.33.0210071331220.10749-100000@penguin.transmeta.com> <3DA1F9AD.1F3BF949@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA1F9AD.1F3BF949@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 02:16:29PM -0700, Andrew Morton wrote:
> Last time, Al suggested that we always use the find_group_other() approach
> if the directory is being made at the top-level of the filesystem.  So
> if /home is a mountpoint, the user directories get spread out.
> 
> I think this, and the UID comparison will be good enough.

Not everyone puts /home or similar on a seperate mount point.  Why not
spread them out always for uid 0 and the parent directory is older than X?
