Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132060AbQK0Fss>; Mon, 27 Nov 2000 00:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132143AbQK0Fsj>; Mon, 27 Nov 2000 00:48:39 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:18440 "EHLO
        munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
        id <S132060AbQK0FsY>; Mon, 27 Nov 2000 00:48:24 -0500
Date: Mon, 27 Nov 2000 00:19:23 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Universal debug macros.
Message-ID: <20001127001923.B16176@munchkin.spectacle-pond.org>
In-Reply-To: <200011270045.BAA13121@cave.bitwizard.nl> <Pine.LNX.4.10.10011270302570.24716-100000@yle-server.ylenurme.sise> <8vsno2$pc6$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <8vsno2$pc6$1@cesium.transmeta.com>; from hpa@zytor.com on Sun, Nov 26, 2000 at 08:25:38PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2000 at 08:25:38PM -0800, H. Peter Anvin wrote:
> Followup to:  <Pine.LNX.4.10.10011270302570.24716-100000@yle-server.ylenurme.sise>
> By author:    Elmer Joandi <elmer@ylenurme.ee>
> In newsgroup: linux.dev.kernel
> > 
> > Red Hat will ship two kernels. Well, they actually ship now about 4 ones
> > or something. So they will ship 8.
> > 
> 
> Something RedHat & co may want to consider doing is providing a basic
> kernel and have, as part of the install procedure or later, an
> automatic recompile and install kernel procedure.  It could be
> automated very easily, and on all but the very slowest of machines, it
> really doesn't take that long.

(Note, I work in the GCC group, not the Linux group, so the following is MHO,
and not Red Hat gospel).

Assuming you've installed the compiler/other relevant tools, installed the
kernel source, and have enough disk space to build the kernel.  This would
screw people wanting to install Linux on their old 386/486/pentium for use as a
firewall or web server.  For example, the machine I'm planning on moving a web
server to only has 2 gig of disk.  Right now, I have barely enough space to
hold the compiler tools plus web pages I want to serve.  If I was serving much
more content, I would probably chuck the compiler tools/kernel source.

-- 
Michael Meissner, Red Hat, Inc.
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
