Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133051AbRDZBwX>; Wed, 25 Apr 2001 21:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133056AbRDZBwN>; Wed, 25 Apr 2001 21:52:13 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:21004 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S133051AbRDZBv7>;
	Wed, 25 Apr 2001 21:51:59 -0400
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Architecture-specific include files
In-Reply-To: <20010422210118.Z18464@parcelfarce.linux.theplanet.co.uk>
From: Jes Sorensen <jes@linuxcare.com>
Date: 26 Apr 2001 03:51:39 +0200
In-Reply-To: Matthew Wilcox's message of "Sun, 22 Apr 2001 21:01:18 +0100"
Message-ID: <d34rvc2ztg.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matthew" == Matthew Wilcox <matthew@wil.cx> writes:

Matthew> Something which came up in one of the hallway discussions at
Matthew> the kernelsummit was that a lot of the architecture
Matthew> maintainers would find it more convenient if the
Matthew> arch-specific header files were moved from include/asm-$ARCH
Matthew> to arch/$ARCH/include.  Since we use a symlink _anyway_, no
Matthew> global changes to include statements are necessary, we'd
Matthew> merely need to change Makefile from

[snip]

Matthew> Would anyone have a problem with this change?  It'll make for
Matthew> a hell of a big patch from Linus, but it really will simplify
Matthew> the lives of the architecture maintainers.

I don't see what it saves, except for the fact you just have to run
diff -urN once instead of twice when you want to send Linus a large
diff. Or am I missing something?

Jes
