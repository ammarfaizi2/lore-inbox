Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262721AbSKDU3m>; Mon, 4 Nov 2002 15:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262743AbSKDU3l>; Mon, 4 Nov 2002 15:29:41 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:37054 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S262721AbSKDU3l>;
	Mon, 4 Nov 2002 15:29:41 -0500
From: Cort Dougan <cort@fsmlabs.com>
Date: Mon, 4 Nov 2002 13:34:20 -0700
To: Tom Rini <trini@kernel.crashing.org>
Cc: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021104133420.E20427@duath.fsmlabs.com>
References: <20021030233605.A32411@jaquet.dk> <20021031132607.E21801@borg.org> <20021031185308.GE30193@opus.bloom.county> <200211012054.34338.landley@trommello.org> <20021104195005.GB27298@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021104195005.GB27298@opus.bloom.county>; from trini@kernel.crashing.org on Mon, Nov 04, 2002 at 12:50:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm with you on that.  People who clammer ignorantly about image size
without looking at what they actually need should have opened their eyes in
the last few years.  Flash and RAM sizes under 32M are nearly unheard of
now-a-days.

It would be a real disaster to construct a screwy and hard-to-maintain
config system in order to achieve something that isn't necessary.  Image
size does matter sometimes but a _maintainable_ and easy to use config
system is far more important.

There are cases where squeezing the image is necessary for extremely
specific applications of the system but those are darn rare now.

} CONFIG_TINY is an attempt to make it 'easier' on the embedded world.  I
} work in the embedded world.  I'm trying to point out that kernel size is
} not the biggest problem facing embedded linux people.  It's making the
} kernel flexible enough, without being a guru of every subsystem you need
} to change.
