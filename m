Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbUJaQ6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbUJaQ6O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 11:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbUJaQ6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 11:58:14 -0500
Received: from 212-28-208-94.customer.telia.com ([212.28.208.94]:12297 "EHLO
	www.dewire.com") by vger.kernel.org with ESMTP id S261311AbUJaQ6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 11:58:11 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Nathan Scott <nathans@sgi.com>
Subject: Re: XFS strangeness, xfs_db out of memory
Date: Sun, 31 Oct 2004 17:58:05 +0100
User-Agent: KMail/1.7.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
References: <200410240857.31893.robin.rosenberg.lists@dewire.com> <20041029073723.GH1246@frodo>
In-Reply-To: <20041029073723.GH1246@frodo>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410311758.06096.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 October 2004 09.37, Nathan Scott wrote:
> On Sun, Oct 24, 2004 at 08:57:26AM +0200, Robin Rosenberg wrote:
> > Hi,
> >
> > I was testing a tiny script on top of xfs_fsr to show fragmentation and
> > the resultss of defragmentation.  As a result of fine tuning the output I
> > ran the script repeatedly and suddenly got error from find (unknown error
> > 999 if my memory serves me. It scrolled off the screen).
> > ...
> > xfs_info $dev
> > xfs_db -r $dev -c "frag -v"
>
> This is accessing the device while the filesystem is mounted,
> in older kernels (like the one you have) that would cause the
> above corruption error in XFS - thats resolved now.

You don't happen to know when or where (patch) this was fixed? I'm usually
using Mandrake stock kernels, so I'm looking for something to attach to a
bug report. I was looking around without luck.

-- robin

