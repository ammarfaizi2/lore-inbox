Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273442AbRIRTlq>; Tue, 18 Sep 2001 15:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273449AbRIRTlg>; Tue, 18 Sep 2001 15:41:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:17304 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273442AbRIRTlZ>;
	Tue, 18 Sep 2001 15:41:25 -0400
Date: Tue, 18 Sep 2001 15:41:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010918131419.A14526@turbolinux.com>
Message-ID: <Pine.GSO.4.21.0109181529390.27125-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Andreas Dilger wrote:

> The real question is why can't we just open 2.5 and only fix the VM to
> start with?  Leave the kernel at 2.4.10-pre10, and possibly use the -ac
> VM code (which has diverged from mainline), and leave people (Alan, Ben,
> Marcello, et. al.) who want to tinker with it in small increments and
> do the drastic stuff in 2.5.

I'd rather get a list of API changes planned for 2.5 and DO ONLY THEM.
IOW, start 2.5 with a sequence of patches that do nothing but a global
search-and-replace.  Then treat it as -STABLE.  It _is_ doable - check
what had happened to superblock handling in 2.4.  Yes, it takes extra
work on splitup and doing things in compatible way, but it's not a
rocket science - BTDT.

"I can't be arsed to split my K'R4D 3133t 200Kb p47cH" had lost its charm
years ago - just look at the devfs mess...

