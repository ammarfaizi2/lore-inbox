Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVACMN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVACMN3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 07:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVACMN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 07:13:29 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:63720 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261398AbVACMNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 07:13:24 -0500
Subject: Re: starting with 2.7
From: Steven Rostedt <rostedt@goodmis.org>
To: Adam Mercer <ramercer@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <799406d60501021649737f1bd@mail.gmail.com>
References: <1697129508.20050102210332@dns.toxicfilms.tv>
	 <20050102203615.GL29332@holomorphy.com>
	 <20050102212427.GG2818@pclin040.win.tue.nl>
	 <20050102214211.GM29332@holomorphy.com> <20050102221534.GG4183@stusta.de>
	 <20050103001917.GO29332@holomorphy.com> <20050103003857.GJ4183@stusta.de>
	 <799406d60501021649737f1bd@mail.gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 03 Jan 2005 07:13:16 -0500
Message-Id: <1104754396.20042.283.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-03 at 00:49 +0000, Adam Mercer wrote:
> On Mon, 3 Jan 2005 01:38:58 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> 
> > 2.4.27 -> 2.4.28 is a kernel upgrade that is very unlikely to cause
> > problems.
> > 
> > Compared to this, 2.6.9 -> 2.6.10 is much more likely to break an
> > existing setup that worked in 2.6.9 .

Yes, it broke my NVIDIA module. I had to hack it to get it to work. Yes,
yes, I know NVIDIA bad and all that, but it is an example, and those
that have NVIDIA cards and want 3D graphics, need to bow to the evil
power that is.

> 
> IIRC 2.4.9 -> 2.4.10 broke a few setups as well.
> 

IIRC, there was a big argument to what was going on in the 2.4.9->2.4.10
kernel. Mainly the new VM. Alan Cox didn't want to include it because a
change like that was too big for a stable release. Actually, I thought
that 2.4.0 -> 2.4.14 was still unstable, and didn't migrate much on my
"stable" machines, until 2.4.14. 

I think both approaches have their pros and cons. Maybe the problem is
that 2.x -> 2.x+1 is too slow.  If it was faster, then it wouldn't be a
problem. The way I develop applications/libraries is that if I change an
interface, it changes the second number, and if I make major changes the
first is changed. Maybe keep 2.6.x just for bug fixes (like usual) and
start 2.7 for updates and jump quicker to 2.8. When a major design is
done, that should be 3.0.  I believe that the kernel has settled with
the 2.6 series to not be jumping to something different as 2.4->2.6 did
any time soon. So maybe make 3.0 the next big change, and let the 2.x
rise quicker.

As to use the distribution kernels? People do that? The first thing I do
when installing a distribution, is to download and run the latests
kernel ;-)

-- Steve


