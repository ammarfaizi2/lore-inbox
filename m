Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261794AbSI2VLY>; Sun, 29 Sep 2002 17:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261795AbSI2VLY>; Sun, 29 Sep 2002 17:11:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59397 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261794AbSI2VLX>; Sun, 29 Sep 2002 17:11:23 -0400
Date: Sun, 29 Sep 2002 22:16:28 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jbradford@dial.pipex.com,
       Linus Torvalds <torvalds@transmeta.com>, jdickens@ameritech.net,
       mingo@elte.hu, jgarzik@pobox.com, kessler@us.ibm.com,
       linux-kernel@vger.kernel.org, saw@saw.sw.com.sg, rusty@rustcorp.com.au,
       richardj_moore@uk.ibm.com, andre@master.linux-ide.org
Subject: Re: v2.6 vs v3.0
Message-ID: <20020929221628.E15924@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com> <200209290716.g8T7GNwf000562@darkstar.example.net> <20020929091229.GA1014@suse.de> <1033311400.13001.5.camel@irongate.swansea.linux.org.uk> <20020929153817.GC1014@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020929153817.GC1014@suse.de>; from axboe@suse.de on Sun, Sep 29, 2002 at 05:38:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 05:38:17PM +0200, Jens Axboe wrote:
> SCSI drivers can be a real problem. Not the porting of them, most of
> that is _trivial_ and can be done as we enter 3.0-pre and people show up
> running that on hardware that actually needs to be ported. The worst bit
> is error handling, this I view as the only problem.

2.4.19 SCSI error handling leaves a lot to be desired currently.  I have
a growing pile of patches that fix up that mess.  They are/have been having
an airing on linux-scsi.

Unfortunately, Alan seems to be ignoring those which linux-scsi is happy
with for unknown reasons currently, so I haven't sent them to Marcelo
(even the ones linux-scsi have said should go to Marcelo; I'd prefer them
to get an airing and some feedback from elsewhere first.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

