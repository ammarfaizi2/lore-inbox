Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSH0Un2>; Tue, 27 Aug 2002 16:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSH0Un2>; Tue, 27 Aug 2002 16:43:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:9186 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317232AbSH0Un1>;
	Tue, 27 Aug 2002 16:43:27 -0400
Date: Tue, 27 Aug 2002 16:47:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.32
In-Reply-To: <20020827224322.24561e60.us15@os.inf.tu-dresden.de>
Message-ID: <Pine.GSO.4.21.0208271646090.6084-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Aug 2002, Udo A. Steinberg wrote:

> On Tue, 27 Aug 2002 12:47:16 -0700 (PDT)
> Linus Torvalds <torvalds@transmeta.com> wrote:
> 
> > Linux 2.5.32 ...
> 
> Hello,
> 
> It looks like the kernel is trying to read partition tables on IDE cdrom drives
> in SCSI emulation mode - and failing at doing so.

IDE merge is b0rken wrt partitioning.  Patchset that is supposed to fix
that stuff is on ftp.math.psu.edu/pub/viro/IDE/* - waiting for ACK from
Alan.

