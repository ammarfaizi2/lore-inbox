Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316939AbSE1Ush>; Tue, 28 May 2002 16:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316915AbSE1Up5>; Tue, 28 May 2002 16:45:57 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1437 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316935AbSE1Uns>;
	Tue, 28 May 2002 16:43:48 -0400
Date: Mon, 27 May 2002 08:53:02 +0000
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@suse.de>, Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        "J.A. Magallon" <jamagallon@able.es>, Luca Barbieri <ldb@ldb.ods.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1 -march=pentium{-mmx,3,4}
Message-ID: <20020527085301.A38@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.44.0205260128110.2047-100000@Expansa.sns.it> <Pine.LNX.4.44.0205260044270.10923-100000@sharra.ivimey.org> <20020526023009.G16102@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I would be (pleasantly) surprised to see gcc turn a C memcpy into faster
> assembly than our current implementation. And I'll bet

gcc has hand-coded assembly inside itself, if gcc compiled memcpy is slower
than hand-optimized one, you found a compiler bug.

>  it'll stay that way for some time.
> gcc has come on in leaps and bounds, but for something as performance
> critical as memory copying/clearing, hand tuned assembly wins hands down.
> Even AMD's/Intel's performance guides suggest doing this. It's the only
> way to fly.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

