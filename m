Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315357AbSEBTCJ>; Thu, 2 May 2002 15:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSEBTCJ>; Thu, 2 May 2002 15:02:09 -0400
Received: from [195.39.17.254] ([195.39.17.254]:63122 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S315357AbSEBTCG>;
	Thu, 2 May 2002 15:02:06 -0400
Date: Fri, 26 Apr 2002 15:29:44 +0000
From: Pavel Machek <pavel@suse.cz>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE hotplug support?
Message-ID: <20020426152943.A413@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.44.0204301746020.2301-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I came across a nice case from procase, supporting 16 IDE drives in 
> (so-called?) hotplug frames. Problem is... How will linux trat this?

Should be okay. Hdparm can force spindown and bus rescan, and that's 
basically what you need.

> I plan to use 15 drives in a RAID-5, assigning the last 16th drive as a 
> spare.

8 controllers? hmmm...

> Any good ideas?
> 
> Sorry if this is OT

It is not.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

