Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273978AbRISBTn>; Tue, 18 Sep 2001 21:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273979AbRISBTc>; Tue, 18 Sep 2001 21:19:32 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:12534
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S273978AbRISBTV>; Tue, 18 Sep 2001 21:19:21 -0400
Date: Tue, 18 Sep 2001 18:19:39 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Forced umount (was lazy umount)
Message-ID: <20010918181939.D10602@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <fa.d1dh3vv.fmmj8f@ifi.uio.no> <fa.e30ljmv.19jambt@ifi.uio.no> <0a0c01c140a8$92b45620$1a01a8c0@allyourbase>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a0c01c140a8$92b45620$1a01a8c0@allyourbase>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 09:15:24PM -0400, Dan Maas wrote:
> > Imagine (common error for me):
> >
> > cd /cdrom
> > kwintv &
> > [work]
> >
> > I now want to umount cdrom. How do I do it? Do you suggest each app
> > to have "cd /" menu entry?
> > Pavel
> 
> No but now that you mention it, it might be a good idea for GUI programs to
> chdir("/") by default immediately on startup. (and fork/daemonize so they
> don't disappear if you accidentally close the xterms you used to start them)
> 

Just disown it after you bg it ie:

xmms & disown
