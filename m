Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271578AbRINXrW>; Fri, 14 Sep 2001 19:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271589AbRINXrL>; Fri, 14 Sep 2001 19:47:11 -0400
Received: from mx2.port.ru ([194.67.57.12]:61444 "EHLO smtp2.port.ru")
	by vger.kernel.org with ESMTP id <S271578AbRINXq6>;
	Fri, 14 Sep 2001 19:46:58 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109150404.f8F44wV02060@vegae.deep.net>
Subject: Re: tail corruptions: saga continues
To: vs@namesys.com (Vladimir V. Saveliev)
Date: Sat, 15 Sep 2001 04:04:01 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BA080E2.39742E30@namesys.com> from "Vladimir V. Saveliev" at Sep 13, 2001 01:48:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"  Vladimir V. Saveliev wrote:"
> 
> Hi
> 
> > Subject: tail corruptions: saga continues
> > Date: Thu, 13 Sep 2001 00:33:23 +0000 (UTC)
> > From: Samium Gromoff <_deepfire@mail.ru>
> > To: reiser@namesys.com
> > CC: linux-kernel@vger.kernel.org
> >
> >          2.4.7/3.x.0k-pre8 pair in _very_rare_ circumsistances
> 
> You should get 3.x.0k-pre9.
   Ouch! Actually that was pre9... sorry for a mistake.
> 
> >
> >     gives tails corruptions with --rebuild-tree.
> 
> >     Actually i found only one file filled with "." (ofcourse <4k)
> >          As a detail, on sudden reboots i have log tails filled with "."
> >     but it seems to be unrelated.
> >          It may look like this one file "." fill was caused by sudden
> >     inability to sync while corruption raised, but in fact at the moment
> >     when fs was corrupted i havent accessed this file for ages... (.c file)
> >
> 
> So, am I correct that before running reiserfsck --rebuild-tree the file
> contained proper data and did not after it?
  Yep
> Or the file appeared corrupted after sudden reboot/mount and it was not
> touched before that sudden crash?
> 
> Why did you decide to run --rebuild-tree? Did reiserfsck --check recommend you
> to do that?
  To repair fs with some blocks set to zero. Zeroified blks are unrelated though...
> 
> Thanks,
> vs
> 
> 
> 

