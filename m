Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279369AbRJWLOM>; Tue, 23 Oct 2001 07:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279371AbRJWLOC>; Tue, 23 Oct 2001 07:14:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:2232 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S279369AbRJWLNy>;
	Tue, 23 Oct 2001 07:13:54 -0400
Date: Tue, 23 Oct 2001 07:14:27 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] cdrom-related rmmod races
In-Reply-To: <200110231057.f9NAvGI31569@ns.caldera.de>
Message-ID: <Pine.GSO.4.21.0110230713140.7440-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Oct 2001, Christoph Hellwig wrote:

> Wouldn't it be easier to add a 'struct module *owner' to struct
> block_device_operations?

All of them share (in the current tree) block_device_operations -
cdrom_fops from drivers/cdrom/cdrom.c.  What will you put as
->owner there?

