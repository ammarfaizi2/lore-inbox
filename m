Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUCCNHn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 08:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbUCCNHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 08:07:43 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:64774 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261685AbUCCNHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 08:07:42 -0500
Subject: Re: Desktop Filesystem Benchmarks in 2.6.3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Olaf =?iso-8859-2?Q?Fr=B1czyk?= <olaf@cbk.poznan.pl>
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       David Weinehall <david@southpole.se>,
       Andrew Ho <andrewho@animezone.org>, Dax Kelson <dax@gurulabs.com>,
       Peter Nelson <pnelson@andrew.cmu.edu>, Hans Reiser <reiser@namesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
In-Reply-To: <1078308797.2641.14.camel@venus.local.navi.pl>
References: <4044119D.6050502@andrew.cmu.edu>
	 <40453538.8050103@animezone.org> <20040303014115.GP19111@khan.acc.umu.se>
	 <200403030700.57164.robin.rosenberg.lists@dewire.com>
	 <1078307033.904.1.camel@teapot.felipe-alfaro.com>
	 <1078308797.2641.14.camel@venus.local.navi.pl>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1078319235.1113.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Wed, 03 Mar 2004 14:07:16 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-03 at 11:13, Olaf Frączyk wrote:
> > > Recoverability matters to me. The driver could be 10 megabyte and
> > > *I* would not care. XFS seems to stand no matter how rudely the OS
> > > is knocked down.

> > But XFS easily breaks down due to media defects. Once ago I used XFS,
> > but I lost all data on one of my volumes due to a bad block on my hard
> > disk. XFS was unable to recover from the error, and the XFS recovery
> > tools were unable to deal with the error.

> You lost all data? Or you just had to restore them from backup? If you
> didn't have a backup it is your fault not XFS one :)

Well, it was a testing machine with no important data, so I could just
afford to lose everything, as it was the case.

> But even if you had no backup, why didn't you move your data (using dd
> or something else) to another (without defects) drive, and run recovery
> on new drive?

I tried, but it proved more difficult than expected, since the computer
was a laptop and I couldn't move the HDD to another computer. Using the
distro rescue CD was useless as it's kernel didn't have XFS support. All
in all, XFS recovery was a nightmare compared to ext3 recovery, for
example.

