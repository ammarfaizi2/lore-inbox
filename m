Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVFHVmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVFHVmH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 17:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVFHVmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 17:42:07 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:64747 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262003AbVFHVmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 17:42:02 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] Re: swsusp: Not enough free pages
Date: Wed, 8 Jun 2005 23:42:13 +0200
User-Agent: KMail/1.8.1
Cc: linux-pm@lists.osdl.org, "Yu, Luming" <luming.yu@intel.com>,
       Andrew Morton <akpm@zip.com.au>,
       ACPI devel <acpi-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
References: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403> <200506081702.53349.rjw@sisk.pl> <20050608162728.GA3969@openzaurus.ucw.cz>
In-Reply-To: <20050608162728.GA3969@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506082342.14420.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 8 of June 2005 18:27, Pavel Machek wrote:
> Hi!
> 
]--snip--[
> > 
> > This is the worst result from the second box:
> > 
> > Freeing memory...  done (54641 pages freed)
> > Freeing memory...  done (0 pages freed)
> > Freeing memory...  done (5120 pages freed)
> > Freeing memory...  done (1952 pages freed)
> > Freeing memory...  done (2304 pages freed)
> > 
> > Still, there are 5x more pages freed in the first pass (80% of RAM was
> > empty anyway before suspend), and usually it is 10-20x more or so.
> 
> I have seen 0 freed on i386 machine with preempt -rc6-mm1, today...
> Something is definitely wrong there.

Well, I have compiled the kernel with preempt and retested (on -rc6) but it
doesn't want to get worse. :-)

The problem seems to be arch-dependent or at least configuration-dependent ... 

Hm, how much RAM is there in your box?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
