Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273745AbRIXC37>; Sun, 23 Sep 2001 22:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273746AbRIXC3t>; Sun, 23 Sep 2001 22:29:49 -0400
Received: from vitelus.com ([64.81.243.207]:13070 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S273745AbRIXC3n>;
	Sun, 23 Sep 2001 22:29:43 -0400
Date: Sun, 23 Sep 2001 19:30:08 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.10 + ext3
Message-ID: <20010923193008.A13982@vitelus.com>
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <1001280620.3540.33.camel@gromit.house> <9om4ed$1hv$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9om4ed$1hv$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 02:06:05AM +0000, Linus Torvalds wrote:
> We'll merge ext3 soon enough.. As RH seems to start using it more and
> more, there's more reason to merge it into the standard kernel too.
> 
> So don't worry. It will happen.

Kinda OT, but ext3 is often treated more like a new file system than
an extension of ext2. I'm wondering if this is a good thing. On the
machines where I use it I have to compile both ext3 and ext2 (because
it would be foolish to not have ext2 support) into the kernel.
Theoretically, is there any reason why the codebases can't be
integrated, allowing you mount ext2 FS' without journalling using only
the ext3 code, and not requring a copy of its ancestor ext2 in the
kernel? Or is there a way already?
