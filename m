Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261964AbSJIUhM>; Wed, 9 Oct 2002 16:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbSJIUhL>; Wed, 9 Oct 2002 16:37:11 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:1108 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S261964AbSJIUhJ>;
	Wed, 9 Oct 2002 16:37:09 -0400
Date: Wed, 9 Oct 2002 22:42:48 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Patrick Mochel <mochel@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
Message-ID: <20021009204248.GA22001@win.tue.nl>
References: <Pine.LNX.4.44.0210091050330.7355-100000@home.transmeta.com> <Pine.GSO.4.21.0210091358100.8980-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210091358100.8980-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 02:00:05PM -0400, Alexander Viro wrote:

> OK, call me dense, but what things are associated with partition aside of the
> fact that it exists?

A partition has an underlying device, a start and a length.
It may have a label or volume id.
It has a partition number (the 7 of hda7) that can be assigned.
It may have substructure on the partition level, like a
DOS-type partition (BSD slice) with BSD subpartitions.

Andries
