Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281694AbRKZOEe>; Mon, 26 Nov 2001 09:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281703AbRKZOEY>; Mon, 26 Nov 2001 09:04:24 -0500
Received: from ns.caldera.de ([212.34.180.1]:60092 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S281701AbRKZOEP>;
	Mon, 26 Nov 2001 09:04:15 -0500
Date: Mon, 26 Nov 2001 15:00:48 +0100
Message-Id: <200111261400.fAQE0mF22150@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: abraham@2d3d.co.za (Abraham vd Merwe)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16-pre1 file system bug
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20011126155633.A370@crystal.2d3d.co.za>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011126155633.A370@crystal.2d3d.co.za> you wrote:
> Hi!

> I mounted 2 vxfs (Veritas / SCO UnixWare) partitions and typed ls in the
> mounted directories. This is the result:

Please add the line

EXTRA_CFLAGS := -DDIAGNOSTIC

to fs/freevxfs/Makefile and send me the dmesg output of the
recompiled kernel.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
