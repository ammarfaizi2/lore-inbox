Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131606AbRCUQqf>; Wed, 21 Mar 2001 11:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131607AbRCUQqP>; Wed, 21 Mar 2001 11:46:15 -0500
Received: from www.wen-online.de ([212.223.88.39]:38157 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131640AbRCUQqG>;
	Wed, 21 Mar 2001 11:46:06 -0500
Date: Wed, 21 Mar 2001 17:45:30 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Kurt Garloff <garloff@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <20010321165948.I3514@garloff.casa-etp.nl>
Message-ID: <Pine.LNX.4.33.0103211738240.1981-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001, Kurt Garloff wrote:

> On Wed, Mar 21, 2001 at 07:41:55AM +0100, Mike Galbraith wrote:
> > On 20 Mar 2001, Kevin Buhr wrote:
> > >     real    60m4.574s
> > >     user    101m18.260s  <-- impossible no?
> > >     sys     3m23.520s
> >
> > Why do numbers like this show up?  I noticed some of this after having
> > enabled SMP on my UP box.
>
> As you have two CPUs, you can spend more time in CPU than your wall clock
> shows if you time multithreaded processes or multiple processes. At most
> (ideal case) twice as much.

Yes.  I'm so used to UP numbers I didn't think.  I saw user larger than
real on my UP box yesterday during some testing, and then seeing this
post... oops.

	-Mike

