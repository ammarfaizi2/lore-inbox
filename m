Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316060AbSENVSx>; Tue, 14 May 2002 17:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316062AbSENVSw>; Tue, 14 May 2002 17:18:52 -0400
Received: from [195.39.17.254] ([195.39.17.254]:6039 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316060AbSENVSv>;
	Tue, 14 May 2002 17:18:51 -0400
Date: Mon, 13 May 2002 17:51:00 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020513175059.B37@toy.ucw.cz>
In-Reply-To: <3CD9E8A7.D524671D@zip.com.au> <5.1.0.14.2.20020509193347.02ff6dc8@mira-sjcm-3.cisco.com> <3CDAC4EB.FC4FE5CF@zip.com.au> <m31yck9700.fsf@averell.firstfloor.org> <3CDB18CF.82DD6D6B@zip.com.au> <20020510030645.A2922@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The tricky bit is to avoid prefetches over the boundary of your copy.
> Prefetching from an uncached area or write combined area (like the 
> AGP gart which could start in next page) triggers hardware bugs in
> various boxes. This unfortunately complicates the prefetching loops
> a bit.

CONFIG_MY_MACHINE_AINT_BORKEN? We definitely could assume that on x86-64.

								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

