Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266384AbRGJOUL>; Tue, 10 Jul 2001 10:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266387AbRGJOUB>; Tue, 10 Jul 2001 10:20:01 -0400
Received: from ns.caldera.de ([212.34.180.1]:21192 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S266384AbRGJOTv>;
	Tue, 10 Jul 2001 10:19:51 -0400
Date: Tue, 10 Jul 2001 16:19:43 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Christoph Hellwig <hch@ns.caldera.de>, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Subject: Re: How many pentium-3 processors does SMP support?
Message-ID: <20010710161943.A7785@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>, Chris Wedgwood <cw@f00f.org>,
	Christoph Hellwig <hch@ns.caldera.de>, linux-kernel@vger.kernel.org,
	hpa@zytor.com
In-Reply-To: <200107101412.f6AEC0W06951@ns.caldera.de> <20010711021639.B31966@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010711021639.B31966@weta.f00f.org>; from cw@f00f.org on Wed, Jul 11, 2001 at 02:16:39AM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 02:16:39AM +1200, Chris Wedgwood wrote:
> On Tue, Jul 10, 2001 at 04:12:00PM +0200, Christoph Hellwig wrote:
> 
>     Why limit the user?  There are more than enough Linux system that
>     have more than 32 CPUs (SGI, DEC, Sun).
> 
> The limit is architecture dependant, for ia32/i386 is it 32.

The number of CPUs is currently globally limited to 32 by NR_CPUS in
include/linux/threads.h.

>     Making it a per-architecture value or even a config option make a
>     lot more sense.
> 
> It turns out I was full of it, you can buy off the shelf 32-processor
> systems.

You can.  But you cannot buy 32-processor PII (-Xeon) systems that are
supported by Linux.

> In anyone from Compaq is reading this, you should send me a 32-way
> Xeon ASAP just to prove they really work :)

It doesn't.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
