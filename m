Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262191AbSJNVmU>; Mon, 14 Oct 2002 17:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262193AbSJNVmU>; Mon, 14 Oct 2002 17:42:20 -0400
Received: from msp-65-29-16-62.mn.rr.com ([65.29.16.62]:17849 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262191AbSJNVmT>; Mon, 14 Oct 2002 17:42:19 -0400
Date: Mon, 14 Oct 2002 16:47:30 -0500
From: Shawn <core@enodev.com>
To: Christoph Hellwig <hch@infradead.org>, Shawn <core@enodev.com>,
       Michael Clark <michael@metaparadigm.com>,
       Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
Message-ID: <20021014164730.B28737@q.mn.rr.com>
References: <F87rkrlMjzmfv2NkkSD000144a9@hotmail.com> <3DA969F0.1060109@metaparadigm.com> <20021013144926.B16668@infradead.org> <3DA98E48.9000001@metaparadigm.com> <20021013163551.A18184@infradead.org> <20021014092048.A27417@q.mn.rr.com> <20021014172137.D19897@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021014172137.D19897@infradead.org>; from hch@infradead.org on Mon, Oct 14, 2002 at 05:21:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14, Christoph Hellwig said something like:
> On Mon, Oct 14, 2002 at 09:20:48AM -0500, Shawn wrote:
> > Having said all that, given that your premises are true regarding the
> > code design problems you have with EVMS, you have a valid point about
> > including it in mainline. The question is, is this good enough to ignore
> > having a logical device management system?!?
> 
> It is not good enough to ignore it.  It is good enough to postpone
> integration for 2.7.

I just wish logical volume management in general had not been so
abandoned in mainline in the first place. I'm not saying Linus unfairly
excluded patches, and I'm not saying patches weren't available. I'm just
saying the dynamics of Linus and the maintainers did not allow for a
healthy LVM in mainline, resulting in decay.

If LVM1's destiny was to die during 2.5, then I wish there would have
been a replacement ready during 2.5's lifecycle. Otherwise, keep
creaking along with what's there, and fix it.

The larger question of volume management should have been addressed
before this whole mess happened. It really was, but LVM1 maintenance was
somewhat abandoned in favor of device mapper, and now it's broken, and
the holy wars are upon us again because many are in fear of losing
functionality important to them (at least the ubiquitous nature of the
functonality), and there is panic.

> Now that Al has sorted out lots of the block device mess in 2.5
> I will work together with whoever is interested in it (i.e. the EVMS
> folks) to integrate proper higher-level volume-management into
> the kernel once the next unstable series opens.

I look forward to it. In spite of my personal goals on this, I do
appreciate your pickiness.

> Coing up with lots of code just before feature freeze is just not the way
> infrastructure work is done Linux.

I just wish there were less veto-esque ways to handle EVMS in *-stable.

--
Shawn Leas
core@enodev.com

I put my air conditioner in backwards.  It got cold outside.
The weatherman on TV was confused.  "It was supposed to be hot
today."
						-- Stephen Wright
