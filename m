Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSFEKfx>; Wed, 5 Jun 2002 06:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315167AbSFEKfx>; Wed, 5 Jun 2002 06:35:53 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:17156 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S314835AbSFEKfv>; Wed, 5 Jun 2002 06:35:51 -0400
Message-ID: <3CFDEA79.2980BF8D@zip.com.au>
Date: Wed, 05 Jun 2002 03:39:53 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
CC: Andreas Dilger <adilger@clusterfs.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
In-Reply-To: <3CFD50B9.259366F4@zip.com.au> <1023272806.15438.106.camel@bip>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:
> 
> Le mer 05/06/2002 à 01:43, Andrew Morton a écrit :
> 
> > Also, it has been suggested that the feature become more fully-fleshed,
> > to support desktops with one disk spun down, etc.  It's not really
> > rocket science to do that - the `struct backing_dev_info' gives
> > a specific communication channel between the high-level VFS code and
> > the request queue.  But that would require significantly more surgery
> > against the writeback code, so I'm fishing for requirements here.  If
> > the current (simple) patch is sufficient then, well, it is sufficient.
> 
> Have per-disk laptop-mode, so that some user-mode proggy (e.g. hotplug)
> could decide what to do.

But why?

-
