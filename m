Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261740AbSJQRjl>; Thu, 17 Oct 2002 13:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261751AbSJQRjl>; Thu, 17 Oct 2002 13:39:41 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:27778 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261740AbSJQRjj>;
	Thu, 17 Oct 2002 13:39:39 -0400
Date: Thu, 17 Oct 2002 13:45:35 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: David Mansfield <lkml@dm.cobite.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: raid subsystem broken in 2.5.43... blockdev changes?
In-Reply-To: <Pine.LNX.4.44.0210161153420.2876-100000@admin>
Message-ID: <Pine.GSO.4.21.0210171344030.17992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Oct 2002, David Mansfield wrote:

> 
> Hi Al, list,
> 
> I think the latest blockdev (maybe the do_open) changes broke the raid
> subsystem.  In order to 'activate' a raid device, the userland tools open
> the device node (e.g. /dev/md0) to perform ioctls against it, even though
> that device isn't up and running yet.  In 2.5.43 it returns ENXIO.

	I know, patches that handle that are coming to Linus in an hour.

... going net.dead for two days didn't help any ;-/

