Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287880AbSAUTGC>; Mon, 21 Jan 2002 14:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287886AbSAUTFm>; Mon, 21 Jan 2002 14:05:42 -0500
Received: from dialin-145-254-152-022.arcor-ip.net ([145.254.152.22]:24580
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S287880AbSAUTFf>; Mon, 21 Jan 2002 14:05:35 -0500
Message-ID: <3C4C6532.216400EC@loewe-komp.de>
Date: Mon, 21 Jan 2002 20:00:02 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Chris Friesen <cfriesen@nortelnetworks.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com> <E16ShcU-0001ip-00@starship.berlin> <20020121095051.B14139@hq.fsmlabs.com> <3C4C50C9.8C7D5B6F@nortelnetworks.com> <20020121105237.A15414@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com schrieb:
> 
> On Mon, Jan 21, 2002 at 12:32:57PM -0500, Chris Friesen wrote:
> > yodaiken@fsmlabs.com wrote:
> >
> > > So your claim is that:
> > >         Preemption improves latency when there are both kernel cpu bound
> > >         tasks and tasks that are I/O bound with very low cache hit
> > >         rates?
> > >
> > > Is that it?
> > >
> > > Can you give me an example of a CPU bound task that runs
> > > mostly in kernel? Doesn't that seem like a kernel bug?
> >
> > cat /dev/urandom > /dev/null
> 
> Don't see any of Daniel's postulated long latencies there.  (Sorry, but
> I'm having a hard time figuring out what is meant as a serious comment
> here).
> 

This does not count for a "general" kernel:

zisofs reading
e2compr

I will try to compare with preemption kernel patch for out webbox like
device - but there I am mostly interested in "GUI feeling" - and will we
use e2compr on a 2.4.9ac kernel.
