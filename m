Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261947AbSJISmd>; Wed, 9 Oct 2002 14:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261951AbSJISmd>; Wed, 9 Oct 2002 14:42:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53511 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261947AbSJISm0>; Wed, 9 Oct 2002 14:42:26 -0400
Date: Wed, 9 Oct 2002 11:47:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.GSO.4.21.0210091358100.8980-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210091138540.14464-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i
On Wed, 9 Oct 2002, Alexander Viro wrote:
> 
> OK, call me dense, but what things are associated with partition aside of the
> fact that it exists?

Filesystems can be associated with one or more partitions. MD devices are 
associated with one or more partitions. 

Not disks. Partitions.

		Linus


