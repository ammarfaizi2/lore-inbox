Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282823AbRK0HAm>; Tue, 27 Nov 2001 02:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282825AbRK0HAc>; Tue, 27 Nov 2001 02:00:32 -0500
Received: from xi.linuxpower.cx ([204.214.10.168]:28164 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S282823AbRK0HAW>;
	Tue, 27 Nov 2001 02:00:22 -0500
Date: Mon, 26 Nov 2001 16:18:02 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Weinehall <tao@acc.umu.se>, linux-kernel@vger.kernel.org
Subject: Re: Release Policy [was: Linux 2.4.16  ]
Message-ID: <20011126161802.A8398@xi.linuxpower.cx>
In-Reply-To: <Pine.LNX.4.40.0111261216500.88-100000@rc.priv.hereintown.net> <Pine.LNX.4.21.0111261351160.13786-100000@freak.distro.conectiva> <9tu0n2$sav$1@cesium.transmeta.com> <20011126192902.M5770@khan.acc.umu.se> <3C028A8D.8040503@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <3C028A8D.8040503@zytor.com>; from hpa@zytor.com on Mon, Nov 26, 2001 at 10:31:41AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 10:31:41AM -0800, H. Peter Anvin wrote:
> Consistency is a Very Good Thing[TM] (says the one who tries to teach
> scripts to understand the naming.)  The advantage with the -rc naming is
> that it avoids the -pre5, -pre6, -pre-final, -pre-final-really,
> -pre-final-really-i-mean-it-this-time phenomenon when the release
> candidate wasn't quite worthy, you just go -rc1, -rc2, -rc3.  There is no
> shame in needing more than one release candidate.

Why not just disguard this sillyness of alphabetic characters in version
numbers... Just carry through the same structure used by major/minor:
I.e.

2.0.39 < released 2.0.39
2.0.39.1.1 < first development snapshot of the kernel which will eventually
	     be 2.0.40
2.0.39.1.2 < second
2.0.39.1.n < Nth
2.0.39.2.1 < first RC
2.0.39.2.2 < second RC
2.0.39.3.1 < opps! Development went too long and we had to break feature
	     freeze to add important features.
2.0.39.4.1 < Trying to stablize again
2.0.39.4.2 < a few more bugs fixxed
2.0.40	   < Looks like 2.0.39.4.2 got it right!
