Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261845AbRESP47>; Sat, 19 May 2001 11:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261843AbRESP4u>; Sat, 19 May 2001 11:56:50 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:9976 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261562AbRESP4h>; Sat, 19 May 2001 11:56:37 -0400
Date: Sat, 19 May 2001 11:56:26 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@devserv.devel.redhat.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Andrew Morton <andrewm@uow.edu.au>, <Andries.Brouwer@cwi.nl>,
        <torvalds@transmeta.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
 in  userspace
In-Reply-To: <Pine.GSO.4.21.0105190750380.5339-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0105191153400.5829-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 May 2001, Alexander Viro wrote:

> Ben's /dev/md0/<living_horror> is ugly - it's open just for side effects,
> with no IO supposed to happen.

Now that I'm awake and refreshed, yeah, that's awful.  But
echo "hot-add,slot=5,device=/dev/sda" >/dev/md0/control *is* sane.  Heck,
the system can even send back result codes that way.

		-ben


