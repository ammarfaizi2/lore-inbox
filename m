Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280618AbRKBJLF>; Fri, 2 Nov 2001 04:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280617AbRKBJK4>; Fri, 2 Nov 2001 04:10:56 -0500
Received: from uucp.cistron.nl ([195.64.68.38]:46341 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S280616AbRKBJKq>;
	Fri, 2 Nov 2001 04:10:46 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: [Patch] Re: Nasty suprise with uptime
Date: Fri, 2 Nov 2001 09:10:46 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9rtnum$pvl$2@ncc1701.cistron.net>
In-Reply-To: <Pine.LNX.4.30.0111011224440.1053-100000@gans.physik3.uni-rostock.de> <Pine.LNX.4.30.0111020059170.5092-100000@gans.physik3.uni-rostock.de> <20011101182334.P16554@lynx.no>
X-Trace: ncc1701.cistron.net 1004692246 26613 195.64.65.67 (2 Nov 2001 09:10:46 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011101182334.P16554@lynx.no>,
Andreas Dilger  <adilger@turbolabs.com> wrote:
>Probably need to make idle a 64-bit value as well, even if the individual
>items are not, just to avoid potential overflow...

Well idle will still overflow after a bit more than 497 days on a
typical system that is 99% idle, if init_tasks[0]->times.tms_{u,s}time
are left at 32 bits.

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

