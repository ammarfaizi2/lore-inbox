Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315334AbSFOMaw>; Sat, 15 Jun 2002 08:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315335AbSFOMav>; Sat, 15 Jun 2002 08:30:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64522 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315334AbSFOMav>; Sat, 15 Jun 2002 08:30:51 -0400
Date: Sat, 15 Jun 2002 13:30:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Denis Oliver Kropp <dok@directfb.org>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5.21] CyberPro 32bit support and other fixes
Message-ID: <20020615133050.A15283@flint.arm.linux.org.uk>
In-Reply-To: <20020613092323.GA2384@skunk.convergence.de> <Pine.LNX.4.44.0206141550000.21575-100000@www.transvirtual.com> <20020615105547.GA22186@skunk.convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2002 at 12:55:47PM +0200, Denis Oliver Kropp wrote:
> > > There's no speed benefit and
> > > applications running in true/direct color would look wrong.
> > 
> > For userland no but for the kernel we do have a benifiet.
> 
> There's no speed benefit if you write "index|index|index" into the
> framebuffer instead of "red|green|blue".

You're actually asking the wrong question.  "Why is there such a thing as
directcolor" would be a better question.  After all, if there's no "speed
benefit" when why do manufacturers bother implementing it?

Could it be because it allows colours to be dynamically allocated?  Given
a "good enough" allocator which looks over your complete colour usage, you
could probably make better use of the available colours than truecolor
allows.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

