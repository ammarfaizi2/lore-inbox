Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261784AbSJDOGl>; Fri, 4 Oct 2002 10:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261785AbSJDOGl>; Fri, 4 Oct 2002 10:06:41 -0400
Received: from ant.compbio.dundee.ac.uk ([134.36.67.203]:8395 "EHLO
	ant.compbio.dundee.ac.uk") by vger.kernel.org with ESMTP
	id <S261784AbSJDOGK>; Fri, 4 Oct 2002 10:06:10 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] [kkern] AFS filesystem for Linux (2/2)
References: <Pine.LNX.4.33.0210021730170.22980-100000@penguin.transmeta.com>
From: Patrick Audley <linux-kernel@blackcat.ca>
In-Reply-To: <Pine.LNX.4.33.0210021730170.22980-100000@penguin.transmeta.com> (Linus Torvalds's message of "Wed, 2 Oct 2002 17:36:06 -0700 (PDT)")
X-Nsa-Fodder: Vince Foster KGB munitions SCUD missile supercomputer
Date: Fri, 04 Oct 2002 15:11:39 +0100
Message-Id: <w4au1k2uwdg.fsf@ant.compbio.dundee.ac.uk>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Honest Recruiter, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    Linus> Now, admittedly maybe the user-space deamon approach is
    Linus> crap, and what we really want is to have some way to cache
    Linus> network stuff on the disk directly from the kernel, ie just
    Linus> implement a real mapping/page-indexed cachefs that people
    Linus> could mount and use together with different network
    Linus> filesystems.

    Cachefs has been on our most wanted list for a while now in Linux
biocomputing..  Using NFS for huge datasets with cachefs on Solaris is
a breeze and Linux currently offers no alternative
(well... coda/intermezzo are close but no close enough).  A general
purpose cachefs would be beautiful.

                                                Patrick Audley


-- 
`Every program attempts to expand until it can read mail. Those programs
   which cannot so expand are replaced by ones which can.'' 
                  - The Law of Software Development
...
Patrick Audley                paudley@compbio.dundee.ac.uk
Computational Biology         http://www.compbio.dundee.ac.uk
University of Dundee          http://blackcat.ca
Dundee, Scotland              +44 1382 348721

