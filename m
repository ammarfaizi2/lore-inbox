Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266650AbRGOPWd>; Sun, 15 Jul 2001 11:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266647AbRGOPWX>; Sun, 15 Jul 2001 11:22:23 -0400
Received: from weta.f00f.org ([203.167.249.89]:5508 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266621AbRGOPWQ>;
	Sun, 15 Jul 2001 11:22:16 -0400
Date: Mon, 16 Jul 2001 03:22:20 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010716032220.B10635@weta.f00f.org>
In-Reply-To: <E15LL3Y-0000yJ-00@the-village.bc.nu> <0107142211300W.00409@starship> <20010715153607.A7624@weta.f00f.org> <01071515442400.05609@starship> <20010716023911.A10576@weta.f00f.org> <p05100317b7775fc2bd15@[207.213.214.37]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p05100317b7775fc2bd15@[207.213.214.37]>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2001 at 08:06:39AM -0700, Jonathan Lundell wrote:

    At first glance, by the way, the only write barrier I see in the
    SCSI command set is the synchronize-cache command, which completes
    only after all the drive's dirty buffers are written out. Of
    course, without write caching, it's not an issue.

Is the spec you have distributable? I believe some of the early drafts
were, but the final spec isn't.

I'd really like to check it out myself, I alwasy assumed SCSI had the
smarts for write-barriers and force-unit-access but I guess I was
wrong.

Anyhow, I'd like to see the spec for myself if it is something I can
get hold of.



  --cw
