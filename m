Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSGMPrH>; Sat, 13 Jul 2002 11:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315162AbSGMPrG>; Sat, 13 Jul 2002 11:47:06 -0400
Received: from dingo.clsp.jhu.edu ([128.220.34.67]:31181 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S315120AbSGMPrF>;
	Sat, 13 Jul 2002 11:47:05 -0400
Date: Sat, 13 Jul 2002 16:00:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kirk Reiser <kirk@braille.uwo.ca>, linux-kernel@vger.kernel.org
Subject: Re: Advice saught on math functions
Message-ID: <20020713140024.GB163@elf.ucw.cz>
References: <E17T15g-0007mP-00@speech.braille.uwo.ca> <E17T1a9-00037I-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17T1a9-00037I-00@the-village.bc.nu>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Are these functions which are supplied by the FPU?  I've looked
> > through the fpu emulation headers and exp() is the only one I can find
> 
> You can't use FPU operations in the x86 kernel.

Actually, you can do kernel_fpu_begin(); any FPU you want;
kernel_fpu_end(); but it is rarely good idea to do that.
									Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
