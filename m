Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133068AbRDSThJ>; Thu, 19 Apr 2001 15:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133066AbRDSThA>; Thu, 19 Apr 2001 15:37:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26122 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S133024AbRDSTgk>;
	Thu, 19 Apr 2001 15:36:40 -0400
From: rmk@arm.linux.org.uk
Message-Id: <200104191936.UAA01002@raistlin.arm.linux.org.uk>
Subject: Re: Dead symbol elimination, stage 1
To: esr@thyrsus.com
Date: Thu, 19 Apr 2001 20:36:32 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (CML2), kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010419135955.A3841@thyrsus.com> from "Eric S. Raymond" at Apr 19, 2001 01:59:55 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond writes:
> > The ones that show up in arch/arm/def-configs are purely because I've been
> > keeping back the updates to these files; each time the config structure
> > changes, I get a nice big patch from people with the new def-configs.  I
> > didn't want to inflict this too regularly on people.
> 
> I read this as "I haven't fixed the problem because..."  not as "Don't
> fix the problem."  Please be more explicit next time so I won't step on
> your toes?

"Keeping back" implies that _I_ have the necessary changes and have not
passed them on.

> I'm rather disturbed by the amount of crap kxref is turning up -- I
> expected dozens of dodgy bits, but I'm finding hundreds.  We need to pay
> better attention to janitorial issues like this if the kernel code
> isn't going to degenerate into an unmaintainable hairball.

The correct thing to do is to ensure that you are starting with an
up to date copy of the defconfig files.  You can do this by passing them
through CML1's 'make oldconfig' before passing them through kxref.

Working with old files does nobody any good.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

