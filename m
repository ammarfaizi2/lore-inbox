Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317037AbSFFS03>; Thu, 6 Jun 2002 14:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317040AbSFFS02>; Thu, 6 Jun 2002 14:26:28 -0400
Received: from [195.39.17.254] ([195.39.17.254]:39328 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317037AbSFFS02>;
	Thu, 6 Jun 2002 14:26:28 -0400
Date: Sun, 2 Jun 2002 05:47:14 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
Message-ID: <20020602054713.F121@toy.ucw.cz>
In-Reply-To: <3CFD453A.B6A43522@zip.com.au> <3CFD499D.DF6EA8CF@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Here's a patch which is designed to make the kernel play more nicely
> > with portable computers.
> 
> I just had a brainwave.  The following text has been added...
> 
> 
> Aside: there is another reason why disks spin up more often than
> necessary: an application has only read a part of a file, and it needs
> to fetch more of that file later on.  This commonly happens with the
> pagein of executables.  To fix this you can increase the readahead
> tunable of your disk drive to something enormous (say, one gigabyte):

This was not required in my configs...
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

