Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135950AbRECMYU>; Thu, 3 May 2001 08:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136103AbRECMYL>; Thu, 3 May 2001 08:24:11 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:49676 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S135950AbRECMYC>; Thu, 3 May 2001 08:24:02 -0400
Message-ID: <3AF14DC5.17E35108@idb.hist.no>
Date: Thu, 03 May 2001 14:23:33 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre7 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain> <20010428215301.A1052@gruyere.muc.suse.de> <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca> <9cg7t7$gbt$1@cesium.transmeta.com> <20010430104231.C3294@bug.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > >
> > > Whatever happened to that hack that was discussed a year or two ago?
> > > The one where (also on IA32) a magic page was set up by the kernel
> > > containing code for fast system calls, and the kernel would write
> > > calibation information to that magic page. The code written there
> > > would use the TSC in conjunction with that calibration data.

>                                                                 Pavel
> PS: Hmm, how do you do timewarp for just one userland appliation with
> this installed?

1. Kernel solution: give that particular process a different magic page
2. User solution:   Don't obtain time from the magic page.
2a                  By changing program source, if available
2b                  By switching the c library, assuming it is used

Helge Hafting
