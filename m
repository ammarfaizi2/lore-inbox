Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSEDROb>; Sat, 4 May 2002 13:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314831AbSEDROa>; Sat, 4 May 2002 13:14:30 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:48327 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314829AbSEDRO3>;
	Sat, 4 May 2002 13:14:29 -0400
To: Christoph Hellwig <hch@infradead.org>
cc: Guest section DW <dwguest@win.tue.nl>, Jeff Dike <jdike@karaya.com>,
        linux-kernel@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: UML is now self-hosting! 
In-Reply-To: Your message of Sat, 04 May 2002 07:28:49 BST.
             <20020504072849.B2295@infradead.org> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13323.1020532332.1@us.ibm.com>
Date: Sat, 04 May 2002 10:12:12 -0700
Message-Id: <E17434u-0003Sx-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020504072849.B2295@infradead.org>, > : Christoph Hellwig writes:
> On Fri, May 03, 2002 at 03:28:03PM -0700, Gerrit Huizenga wrote:
> > PTX could *almost* run VMWare (might be able to run Win4Lin or Boochs...)
> 
> Umm, you have ported the VMWare and Win4Lin kernel modules?
> For Win4Lin I could almost image it as it is ported UnixWare code..

Nope - that's where the part of the *almost* comes from.  There were
a few other things we didn't get to and the only time I remember someone
trying it was when we still didn't have modify_ldt() ported, so that
also broke.  VMWare wasn't actually a goal - on the same hardware
we could statically partition nodes and some nodes could natively
run NT while some ran PTX.  Now those same nodes can also run Linux
as well.  And we quit putting major development effort into PTX about
two years ago, so we'll probably never find out just how close we
were on VMWare.

gerrit
