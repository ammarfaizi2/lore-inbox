Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267297AbTAAQC3>; Wed, 1 Jan 2003 11:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267298AbTAAQC3>; Wed, 1 Jan 2003 11:02:29 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:23813 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267297AbTAAQC1>; Wed, 1 Jan 2003 11:02:27 -0500
Date: Wed, 1 Jan 2003 11:08:42 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: a few more "make xconfig" inconsistencies
In-Reply-To: <20030101152457.GA15200@louise.pinerecords.com>
Message-ID: <Pine.LNX.3.96.1030101110621.14470D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, Tomas Szepe wrote:

> > [john@grabjohn.com]
> > 
> > In 2.5.53, under Old CD-ROM drivers (not SCSI, not IDE), if you select
> > "Matsushita/Panasonic/Creative, Longshine, TEAC CDROM support", the
> > help text says:
> > 
> > "This driver can support up to four CD-ROM controller cards, and each
> > card can support up to four CD-ROM drives; if you say Y here, you will
> > be asked how many controller cards you have."
> > 
> > The user is not prompted to specify how many controllers they have in
> > 2.5.53, and in 2.4.20-pre2, there are separate options for the 2nd,
> > 3rd, and 4th controllers.
> > 
> > However, I've looked through the code, and I'm not sure if >1
> > controller is actually supported anymore - a lot of the code for that
> > seems to be commented out in 2.4.20-pre2, and completely removed in
> > 2.5.53.
> 
> You'll need to ask the driver's maintainer (if there is one at all,
> that is).

Well, someone seems to have changed the behaviour for 2.5, so perhaps the
problem can be addressed if that person can be identified from the patch
log.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

