Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317045AbSFFS1m>; Thu, 6 Jun 2002 14:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317051AbSFFS1k>; Thu, 6 Jun 2002 14:27:40 -0400
Received: from [195.39.17.254] ([195.39.17.254]:39840 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317045AbSFFS0q>;
	Thu, 6 Jun 2002 14:26:46 -0400
Date: Sun, 2 Jun 2002 05:52:09 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: Andreas Dilger <adilger@clusterfs.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
Message-ID: <20020602055208.G121@toy.ucw.cz>
In-Reply-To: <3CFD453A.B6A43522@zip.com.au> <20020604233124.GA18668@turbolinux.com> <3CFD50B9.259366F4@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> BTW, the "use a gigabyte of readahead" idea would cause VM hysteria
> if you access a 600 megabyte file, so I've wound that back to
> twenty megs.

Twenty megs is still way too much I believe. Well, definitely way too much
on 32MB machine, and I do not think it is required at all.

> Also, it has been suggested that the feature become more fully-fleshed,
> to support desktops with one disk spun down, etc.  It's not really
> rocket science to do that - the 
