Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264833AbSJOWMy>; Tue, 15 Oct 2002 18:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264812AbSJOWMw>; Tue, 15 Oct 2002 18:12:52 -0400
Received: from dsl-213-023-038-160.arcor-ip.net ([213.23.38.160]:54167 "EHLO
	starship") by vger.kernel.org with ESMTP id <S264775AbSJOWMs>;
	Tue, 15 Oct 2002 18:12:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andries Brouwer <aebr@win.tue.nl>, Alexander Viro <viro@math.psu.edu>
Subject: Re: [bk/patch] driver model update: device_unregister()
Date: Wed, 16 Oct 2002 00:18:14 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, Patrick Mochel <mochel@osdl.org>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210091050330.7355-100000@home.transmeta.com> <Pine.GSO.4.21.0210091358100.8980-100000@weyl.math.psu.edu> <20021009204248.GA22001@win.tue.nl>
In-Reply-To: <20021009204248.GA22001@win.tue.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E181a10-0003xJ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 October 2002 22:42, Andries Brouwer wrote:
> On Wed, Oct 09, 2002 at 02:00:05PM -0400, Alexander Viro wrote:
> 
> > OK, call me dense, but what things are associated with partition aside of the
> > fact that it exists?
> 
> A partition has an underlying device, a start and a length.

Subtle distinction: a partition has underlying media, and the media is
associated with a device.

> It may have a label or volume id.
> It has a partition number (the 7 of hda7) that can be assigned.
> It may have substructure on the partition level, like a
> DOS-type partition (BSD slice) with BSD subpartitions.

-- 
Daniel
