Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266013AbRGDRA1>; Wed, 4 Jul 2001 13:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbRGDRAS>; Wed, 4 Jul 2001 13:00:18 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:33384 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S265991AbRGDRAF>; Wed, 4 Jul 2001 13:00:05 -0400
Date: Wed, 4 Jul 2001 12:59:57 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Chris Wedgwood <cw@f00f.org>
cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] first cut 64 bit block support
In-Reply-To: <20010704221658.D18972@weta.f00f.org>
Message-ID: <Pine.LNX.4.33.0107041258370.5503-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2001, Chris Wedgwood wrote:

> On Sun, Jul 01, 2001 at 12:53:25AM -0400, Ben LaHaise wrote:
>
> > Ugly bits: I had to add libgcc.a to satisfy the need for 64 bit
> > division.  Yeah, it sucks, but RAID needs some more massaging before
> > I can remove the 64 bit division completely.  This will be fixed.
>
> I would rather see this code removed from libgcc and put into a
> function (optionally inline) such that code like:

I'm getting rid of the need for libgcc entirely.  That's what "This will
be fixed" means.  If you want to expedite the process, send a patch.
Until then, this is Good Enough for testing purposes.

		-ben

