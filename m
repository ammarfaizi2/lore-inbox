Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbUKWPBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbUKWPBt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 10:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbUKWPBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 10:01:49 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:28298 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261280AbUKWPBo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 10:01:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=tGnJxPBXrTjctBxfpQFPIDsL6LLMC+wciMDJtWLViUMtiN7SYAZBXQ4iN0CRWPLM8nc/tvq616e9KVJTMi956gSru6975BuluM14oTenOMfk4PFyAs+uIq8LyQ3VsIKoZNLZeJdEkDnjMJoiAhxeXfX5b56uTVSnLpLn9/qwkAA=
Message-ID: <2d7d2dd2041123070042d79179@mail.gmail.com>
Date: Tue, 23 Nov 2004 15:00:24 +0000
From: Simon Burke <simon.burke@gmail.com>
Reply-To: Simon Burke <simon.burke@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Umbrella-0.5.1 stable released
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041123144812.GB13174@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <200411231544.09701.ks@cs.aau.dk> <20041123144812.GB13174@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004 15:48:13 +0100, Jens Axboe <axboe@suse.de> wrote:
> On Tue, Nov 23 2004, Kristian Sørensen wrote:
> > Hi all!
> >
> > We are pleased to inform you that Umbrella 0.5.1 is now released. This is a
> > very stable release, which has been tested on our workstations for 6+ days
> > continously.
> >
> > Get the release here:
> > http://prdownloads.sourceforge.net/umbrella/umbrella-0.5.1.tar.bz2?download
> >
> > The strategy of the further development of Umbrella is to have
> > * STABLE and well tested Umbrella as patches
> > * UNSTABLE bleeding edge technology in the CVS module umbrella-devel
> >
> >
> > We have lots of new stuff and optimizations in the CVS, which slowley will be
> > applied and tested before getting realeased as patches. Currently we have
> > these in the CVS:
> > * New, small and efficient bit vector
> > * New datastructure for storing restrictions
> >    See this thread for details:
> >    http://sourceforge.net/mailarchive/forum.php?thread_id=5886152&forum_id=42079
> > * Restrictions on process signaling
> > * Authentication of binaries (still under development for the 0.6 release)
> 
> And umbrella is?
> 
Umbrella for handhelds implements a combination of process based
mandatory access control (MAC) and authentication of files for Linux
on top of the Linux Security Modules framework. The MAC scheme is
enforced by a set of restrictions for each process.

*apparently*  (i just copied out the sourceforge description).

-- 
Theres no place like ::1

Thanks,
SimonB
