Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316568AbSFEXe1>; Wed, 5 Jun 2002 19:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316572AbSFEXe1>; Wed, 5 Jun 2002 19:34:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12815 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316568AbSFEXe0>; Wed, 5 Jun 2002 19:34:26 -0400
Date: Thu, 6 Jun 2002 00:34:20 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add <linux/kdev_t.h> to <linux/bio.h>
Message-ID: <20020606003420.A17872@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com> <20020605232220.GA709@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 04:22:20PM -0700, Tom Rini wrote:
> The following add <linux/kdev_t.h> to <linux/bio.h>.
> 
> This is needed since bio_ioctl takes a kdev_t for its first argument.

This should be fixed by a patch I submitted earlier today (you're getting
a build error in fs/mpage.c, right?)

hch asked the very pertinent question though - why isn't kdev_t defined
by linux/types.h ?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

