Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbUCCKJu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbUCCKJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:09:50 -0500
Received: from goliath.sylaba.poznan.pl ([213.17.226.43]:22284 "EHLO
	goliath.sylaba.poznan.pl") by vger.kernel.org with ESMTP
	id S262383AbUCCKJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:09:47 -0500
Subject: Re: Desktop Filesystem Benchmarks in 2.6.3
From: Olaf =?iso-8859-2?Q?Fr=B1czyk?= <olaf@cbk.poznan.pl>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       David Weinehall <david@southpole.se>,
       Andrew Ho <andrewho@animezone.org>, Dax Kelson <dax@gurulabs.com>,
       Peter Nelson <pnelson@andrew.cmu.edu>, Hans Reiser <reiser@namesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
In-Reply-To: <1078307033.904.1.camel@teapot.felipe-alfaro.com>
References: <4044119D.6050502@andrew.cmu.edu>
	 <40453538.8050103@animezone.org> <20040303014115.GP19111@khan.acc.umu.se>
	 <200403030700.57164.robin.rosenberg.lists@dewire.com>
	 <1078307033.904.1.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1078308797.2641.14.camel@venus.local.navi.pl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 03 Mar 2004 11:13:18 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-03 at 10:43, Felipe Alfaro Solana wrote:
> On Wed, 2004-03-03 at 07:00, Robin Rosenberg wrote:
> > On Wednesday 03 March 2004 02:41, David Weinehall wrote:
> > > On Tue, Mar 02, 2004 at 08:30:32PM -0500, Andrew Ho wrote:
> > > > XFS is the best filesystem.
> > > 
> > > Well it'd better be, it's 10 times the size of ext3, 5 times the size of
> > > ReiserFS and 3.5 times the size of JFS.
> > > 
> > > And people say size doesn't matter.
> > 
> > Recoverability matters to me. The driver could be 10 megabyte and
> > *I* would not care. XFS seems to stand no matter how rudely the OS
> > is knocked down.
> 
> But XFS easily breaks down due to media defects. Once ago I used XFS,
> but I lost all data on one of my volumes due to a bad block on my hard
> disk. XFS was unable to recover from the error, and the XFS recovery
> tools were unable to deal with the error.
You lost all data? Or you just had to restore them from backup? If you
didn't have a backup it is your fault not XFS one :)
But even if you had no backup, why didn't you move your data (using dd
or something else) to another (without defects) drive, and run recovery
on new drive?

Regards,

Olaf 

