Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274178AbRISUiP>; Wed, 19 Sep 2001 16:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274182AbRISUiG>; Wed, 19 Sep 2001 16:38:06 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:59379
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S274178AbRISUhx>; Wed, 19 Sep 2001 16:37:53 -0400
Date: Wed, 19 Sep 2001 13:38:11 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Define conflict between ext3 and raid patches against 2.2.19
Message-ID: <20010919133811.B22773@mikef-linux.matchmail.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010916155835.C24067@mikef-linux.matchmail.com> <15271.11056.810538.66237@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15271.11056.810538.66237@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 09:08:32PM +1000, Neil Brown wrote:
> On Sunday September 16, mfedyk@matchmail.com wrote:
> > Hi,
> > 
> > I'm trying to setup a 2.2 kernel that I can use for comparison to the latest
> > 2.4 kernels I've been testing, but I came accross a little problem with the
> > patches I've been trying to combine.
> > 
> > I've already applied:
> > ide.2.2.19.05042001.patch
> > linux-2.2.19.kdb.diff
> > linux-2.2.19.ext3.diff
> > 
> > And now I'm trying to apply raid-2.2.19-A1, and I get one reject in
> > include/linux/fs.h.
> 
> You should be aware that ext3 (and other journalling filesystems) do
> not work reliably over RAID1 or RAID5 in 2.2.  Inparticular, you can
> get problems when the array is rebuilding/resyncing.
> 
> But if you only plan to use ext3 with raid0 or linear, you should be
> fine.
> 

Can you point me to an archive that describes how to trigger this bug?

Was it in linux-raid or ext3-users or ...?

Mike
