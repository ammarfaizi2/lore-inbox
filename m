Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSEFJxk>; Mon, 6 May 2002 05:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314327AbSEFJxj>; Mon, 6 May 2002 05:53:39 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:58888 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314325AbSEFJxi>; Mon, 6 May 2002 05:53:38 -0400
Date: Mon, 6 May 2002 10:53:31 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.13 IDE 53
Message-ID: <20020506105331.A20048@flint.arm.linux.org.uk>
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC7E358.8050905@evision-ventures.com> <20020425172508.GK3542@suse.de> <20020425173439.GM3542@suse.de> <aa9qtb$d8a$1@penguin.transmeta.com> <3CD55601.9030604@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 05, 2002 at 05:55:45PM +0200, Martin Dalecki wrote:
> - Start splitting the functions for host chip handling in to separate entities.
>    This change is quite sensitive and may cause some trouble but it's for
>    certain worth it anyway, because it should for example provide a much better
>    infrastructure for th handling of different architectures.

Are you at some point going to add the black/white lists back into
icside.c that you removed shortly after you took over the IDE
maintainence?  I've been patiently waiting to see what was going to
happen to them.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

