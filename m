Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129349AbRBBOuk>; Fri, 2 Feb 2001 09:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129244AbRBBOub>; Fri, 2 Feb 2001 09:50:31 -0500
Received: from ffaxvahe3-3-140.cox.rr.com ([24.163.114.140]:1685 "EHLO
	troilus.org") by vger.kernel.org with ESMTP id <S129349AbRBBOuT>;
	Fri, 2 Feb 2001 09:50:19 -0500
To: Paul Flinders <paul@dawa.demon.co.uk>
Cc: Gregory Maxwell <greg@linuxpower.cx>, linux-kernel@vger.kernel.org
Subject: Re: NT soon to surpass Linux in specweb99 performance?
In-Reply-To: <20010201143825.A21237@xi.linuxpower.cx>
	<3A79C156.A8F7FF58@dawa.demon.co.uk>
From: Michael Poole <poole@troilus.org>
Date: 02 Feb 2001 09:50:13 -0500
In-Reply-To: Paul Flinders's message of "Thu, 01 Feb 2001 20:04:38 +0000"
Message-ID: <m3u26duoka.fsf@troilus.org>
User-Agent: Gnus/5.0805 (Gnus v5.8.5) XEmacs/21.1 (Canyonlands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Flinders <paul@dawa.demon.co.uk> writes:

> Gregory Maxwell wrote:
> 
> > Looks like TUX caught MS's attention:
> > http://www.spec.org/osg/web99/results/res2000q4/web99-20001211-00082.html
> >
> > Anyone know if their method of achieveing this is as flexible as TUX, or is
> > their "SWC 3.0" simply mean 'spec web cheat' and involve implimenting the
> > specweb dyanmic stuff in x86 assembly in their microkernel? :)
> 
> Yeah, but Tux 2 is still faster on the same/similar hardware
> 
> http://www.spec.org/osg/web99/results/res2000q4/web99-20001127-00075.html

Well, if you look closely, the Tux 2 system had an extra GigE card and
5 9GB 10KRPM drives instead of 1 9GB 10KRPM drive plus 8 16GB 15KRPM
drives under IIS, so the hardware wasn't exactly the same for both.

Perhaps more telling is that in both cases the "Conforming
Simultaneous Connections" was the same as the "Requested Connections"
-- suggesting that neither TUX 2.0 nor IIS were pushed to the breaking
point in the tests.

Before gloating about holding the highest performance, compare with
Zeus running on a (much beefier) IBM eServer:
http://www.spec.org/osg/web99/results/res2001q1/web99-20001225-00092.html

(And of course the normal disclaimers apply about how little benchmark
results reflect what "average" commercial deployments see.)

-- Michael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
